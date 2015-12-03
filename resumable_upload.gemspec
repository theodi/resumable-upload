$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "resumable_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "resumable_upload"
  s.version     = ResumableUpload::VERSION
  s.authors     = "Ben Couston"
  s.email       = "TODO: Your email"
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ResumableUpload."
  s.description = "TODO: Description of ResumableUpload."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.13"
  s.add_dependency "bson", "3.1.1"
  s.add_dependency "fog", "~> 1.36"
  s.add_dependency "dotenv", "~> 2.0"

  s.add_development_dependency "pry"
  s.add_development_dependency "sqlite3"
end
