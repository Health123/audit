# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require "audit/version"

Gem::Specification.new do |s|
  s.name = "audit"
  s.summary = "Simple audit gem."
  s.description = "Simple audit system."
  s.version     = Audit::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.homepage    = "http://github.com/sparrow/audit"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "capybara"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
end