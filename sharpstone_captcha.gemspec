$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sharpstone_captcha/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sharpstone_captcha"
  s.version     = SharpstoneCaptcha::VERSION
  s.authors     = ["Mark S. Miller"]
  s.email       = ["mark.s.miller@gmail.com"]
  s.homepage    = "http://www.siliconchisel.com"
  s.summary     = "Summary of SharpstoneCaptcha."
  s.description = "Description of SharpstoneCaptcha."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0"

  s.add_development_dependency "sqlite3"
end
