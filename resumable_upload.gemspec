$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "resumable_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "resumable_upload"
  s.version     = ResumableUpload::VERSION
  s.authors     = ["Ben Couston", "Stuart Harrison", "Sam Pikesley"]
  s.email       = "ops@theodi.org"
  s.homepage    = "https://github.com/theodi/resumable-upload"
  s.summary     = "A Resumable.js Rails Engine"
  s.description = "A Resumable.js Rails Engine"

  s.required_ruby_version = ["~> 2.4", "< 2.6"]

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "bson", ">= 3.1", "< 5.0"
  s.add_dependency "fog", "~> 1.36"
  s.add_dependency "dotenv"

  s.add_development_dependency "pry"
  s.add_development_dependency "sqlite3", "~> 1.3.13"
end
