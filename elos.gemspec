# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elos/version'

Gem::Specification.new do |spec|
  spec.name          = "elos"
  spec.version       = Elos::VERSION
  spec.authors       = ["Tetsuri Moriya"]
  spec.email         = ["tetsuri.moriya@gmail.com"]

  spec.summary       = %q{Elasticsearch integration for Databases}
  spec.description   = %q{Elasticsearch integration for Databases, such as ActiveRecord}
  spec.homepage      = "https://github.com/pandora2000/elos"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
