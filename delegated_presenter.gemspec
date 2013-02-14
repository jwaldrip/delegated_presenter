# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'delegated_presenter/version'

Gem::Specification.new do |gem|
  gem.name            = "delegated_presenter"
  gem.version         = DelegatedPresenter::VERSION
  gem.authors         = ["Jason Waldrip"]
  gem.email           = ["jason@waldrip.net"]
  gem.description     = %q{Simple presenter allows for a simple way for you to present a model to your views without cluttering up the original model.}
  gem.summary         = %q{Simple presenter allows for a simple way for you to present a model to your views without cluttering up the original model.}
  gem.homepage        = "http://github.com/jwaldrip/delegated_presenter"

  gem.files           = `git ls-files`.split($/)
  gem.executables     = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files      = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths   = ["lib"]
  gem.add_dependency  "activesupport"

  gem.add_development_dependency "rspec", '~> 2.12.0'
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "rails"
  gem.add_development_dependency "factory_girl"
  gem.add_development_dependency "database_cleaner"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "rb-fsevent"

end
