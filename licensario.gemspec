# -*- encoding: utf-8 -*-
require File.expand_path('../lib/licensario/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcelo Wiermann"]
  gem.email         = ["marcelo.wiermann@gmail.com"]
  gem.description   = %q{Licensario SDK}
  gem.summary       = %q{Licensario SDK}
  gem.homepage      = "http://www.licensario.com"

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'factory_girl'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'shoulda'
  gem.add_dependency 'rdoc'
  gem.add_dependency 'nokogiri'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "licensario"
  gem.require_paths = ["lib"]
  gem.version       = Licensario::VERSION
end
