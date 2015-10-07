# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kindlr/version'

Gem::Specification.new do |spec|
  spec.name          = 'kindlr'
  spec.version       = Kindlr::VERSION
  spec.authors       = ['Eric Nelson']
  spec.email         = ['enelson@eligoenergy.com']

  spec.summary       = ' Read kindle books from the command line'
  spec.homepage      = 'https://github.com/nelseric/kindlr'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'capybara-webkit', '~> 1.7.1'
  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'table_print', '~> 1.5.4'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.34.2'
  spec.add_development_dependency 'rspec', '~> 3.3.0'

  spec.add_development_dependency 'pry', '~> 0.10.2'

  spec.add_development_dependency 'launchy'
end
