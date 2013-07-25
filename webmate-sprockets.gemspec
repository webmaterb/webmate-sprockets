# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "webmate/sprockets/version"

Gem::Specification.new do |s|
  s.name        = "webmate-sprockets"
  s.version     = Webmate::Sprockets::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["thegorgon", 'Iskander Haziev']
  s.email       = ["jessereiss@gmail.com", 'gvalmon@gmail.com']
  s.homepage    = "https://github.com/webmaterb/webmate-sprockets"
  s.summary     = %q{Webmate helpers for Sprockets integration.}
  s.description = %q{Use Sprockets effectively with Webmate.}

  s.rubyforge_project = s.name

  s.add_dependency 'webmate'

  s.add_runtime_dependency 'sprockets',       '~> 2.10'

  s.files = `git ls-files`.split($/)

  s.require_paths << "lib"
end
