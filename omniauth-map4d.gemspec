# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-map4d/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Cuong Nguyen"]
  gem.email         = ["cuongnc@iotlink.com"]
  gem.description   = %q{Official OmniAuth strategy for Map4d.}
  gem.summary       = %q{Official OmniAuth strategy for Map4d.}
  gem.homepage      = "https://github.com/cuongnc5/omniauth_map4d"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-map4d"
  gem.require_paths = ["lib"]
  gem.version       = "1.0.0"

  gem.add_dependency 'omniauth', '~> 1.5'
  gem.add_dependency 'omniauth-oauth2', '>= 1.4.0', '< 2.0'
  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
