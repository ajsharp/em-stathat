# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "em-stathat/version"

Gem::Specification.new do |s|
  s.name        = "em-stathat"
  s.version     = EventMachine::Stathat::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Sharp"]
  s.email       = ["ajsharp@gmail.com"]
  s.homepage    = "https://github.com/ajsharp/em-stathat"
  s.summary     = %q{An EventMachine-compatible async wrapper for the stathat api.}
  s.description = %q{Essentially a clone of the normal stathat gem, only for use with EventMachine.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'em-http-request', '~> 1.0'
end
