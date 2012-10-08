#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'DelegatedPresenter'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')

ENV["RAILS_ENV"] ||= 'test'

task :default => ['db:migrate', 'db:test:prepare', :spec]

require File.expand_path('../spec/dummy/config/application', __FILE__)
Dummy::Application.load_tasks

Bundler::GemHelper.install_tasks

