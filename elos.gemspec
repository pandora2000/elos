# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elos/version'

Gem::Specification.new do |spec|
  spec.name          = 'elos'
  spec.version       = Elos::VERSION
  spec.authors       = ['Tetsuri Moriya']
  spec.email         = ['tetsuri.moriya@gmail.com']

  spec.summary       = %q{Elasticsearch integration for Databases}
  spec.description   = %q{Elasticsearch integration for Databases, such as ActiveRecord}
  spec.homepage      = 'https://github.com/pandora2000/elos'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  [['activesupport', '>= 3.0.0'],
   ['elasticsearch']].each do |args|
    spec.add_dependency *args
  end

  [['bundler', '~> 1.9'],
   ['rake', '~> 10.0'],
   ['rspec', '>= 0'],
   ['database_cleaner', '~> 1.2.0'],
   ['activerecord'],
   ['mysql2']].each do |args|
    spec.add_development_dependency *args
  end
end
