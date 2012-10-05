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
  gem.add_development_dependency "rspec"
end
