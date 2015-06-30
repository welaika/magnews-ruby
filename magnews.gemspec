# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magnews/version'

Gem::Specification.new do |spec|
  spec.name          = "magnews-ruby"
  spec.version       = Magnews::VERSION
  spec.authors       = ["Filippo Gangi Dino", "Fabrizio Monti"]
  spec.email         = ["filippo.gangidino@welaika.com", "fabrizio.monti@welaika.com"]

  spec.summary       = %q{Unofficial Magnews REST API ruby interface  }
  spec.description   = %q{}
  spec.homepage      = "https://github.com/welaika/magnews-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.8.0"
  spec.add_dependency "activesupport", "< 4.2"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "shoulda-matchers", "~> 2.8.0"
  spec.add_development_dependency "pry-byebug", "~> 3.1.0"
  spec.add_development_dependency "webmock", "~> 1.21.0"
  spec.add_development_dependency "simplecov", "~> 0.10.0"
  spec.add_development_dependency "priscilla", "~> 1.0.3"
end
