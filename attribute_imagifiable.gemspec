# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attribute_imagifiable/version'

Gem::Specification.new do |gem|
  gem.name          = "attribute_imagifiable"
  gem.version       = "0.0.1"
  gem.authors       = ["Stefan Wienert", "Akos Toth"]
  gem.email         = ["stefan.wienert@pludoni.de"]
  gem.description   = %q{Using paperclip to generate images from sensible attributes like e-mails and telephone numbers, in order to reduce crawler's success}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end