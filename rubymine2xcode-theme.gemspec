# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rubymine2xcode-theme/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matt Connolly"]
  gem.email         = ["matt.connolly@me.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec,spec,features}/*`.split("\n")
  gem.name          = "rubymine2xcode-theme"
  gem.require_paths = ["lib"]
  gem.version       = Rubymine2Xcode::VERSION

  gem.add_dependency 'plist'

  gem.add_development_dependency 'rspec'

end
