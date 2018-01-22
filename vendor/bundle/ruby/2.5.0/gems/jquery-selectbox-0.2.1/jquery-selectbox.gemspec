# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jquery-selectbox/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alif Rachmawadi"]
  gem.email         = ["subosito@gmail.com"]
  gem.description   = %q{Custom select box replacement inspired by jQuery UI source}
  gem.summary       = %q{jQuery Selectbox plugin. Custom select box replacement inspired by jQuery UI source. Require jQuery 1.4.x or higher}
  gem.homepage      = "https://github.com/subosito/jquery-selectbox"
  gem.licenses      = ["MIT"]

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jquery-selectbox"
  gem.require_paths = ["lib"]
  gem.version       = Jquery::Selectbox::VERSION

  gem.add_dependency 'railties', '>= 3.1'
  gem.add_development_dependency 'vendorer'
  gem.add_development_dependency 'tzinfo'
  gem.add_development_dependency 'sass-rails'
end
