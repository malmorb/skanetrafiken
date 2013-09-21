# -*- encoding: utf-8 -*-
lib = File.expand_path('./lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
  
Gem::Specification.new do |s|
  s.name        = "Skanetrafiken"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Oskar Gewalli"]
  s.email       = ["oskar@gewalli.se"]
  s.homepage    = "https://github.com/wallymathieu/skanetrafiken"
  s.summary     = "Using ruby to query the API provided by Skanetrafiken"
  s.description = "Using ruby to query some of the API for Skanetrafiken. It can be found at http://www.labs.skanetrafiken.se/api.asp"
 
  s.files        = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
end