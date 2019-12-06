require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Map4d < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://account.map4d.vn',
        :authorize_url => 'https://account.map4d.vn/oauth/authorize',
        :token_url => 'https://account.map4d.vn/oauth/access_token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'email' => raw_info['email'],
          'name' => raw_info['name'],
          'image' => raw_info['avatar_url'],
          'provider' => 'map4d',
        }
      end

      extra do
        {:raw_info => raw_info, :all_emails => emails}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('api/get-user-info').parsed
      end

      def email
        (email_access_allowed?) ? primary_email : raw_info['email']
      end

      def primary_email
        primary = emails.find{ |i| i['primary'] && i['verified'] }
        primary && primary['email'] || nil
      end

      # The new /user/emails API - http://developer.github.com/v3/users/emails/#future-response
      def emails
        return [] unless email_access_allowed?
        access_token.options[:mode] = :query
        @emails ||= access_token.get('user/emails', :headers => { 'Accept' => 'application/vnd.github.v3' }).parsed
      end

      def email_access_allowed?
        return false unless options['scope']
        email_scopes = ['user', 'user:email']
        scopes = options['scope'].split(',')
        (scopes & email_scopes).any?
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'map4d', 'Map4d'
