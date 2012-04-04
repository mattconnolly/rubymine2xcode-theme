# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rubymine2xcode-theme/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matt Connolly"]
  gem.email         = ["matt.connolly@me.com"]
  gem.description   = %q{A tool for converting Rubymine XML theme files into Xcode theme files}
  gem.summary       = <<-EOT
    A tool for converting Rubymine XML theme files into Xcode theme files.
    The resulting Xcode theme file will automatically be saved into the correct
    Library path where Xcode will find it for the current user.
  EOT
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
