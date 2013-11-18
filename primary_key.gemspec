$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "primary_key/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "primary_key"
  s.version     = PrimaryKey::VERSION
  s.authors     = ["Sujoy Gupta"]
  s.email       = ["sujoyg@gmail.com"]
  s.homepage    = "http://www.github.com/sujoyg/primary_key"
  s.summary     = "Primary keys for Rails migrations."
  s.description = "Adds an add_primary_key method for Rails migrations."
  s.license     = "MIT"

  s.files = Dir["{config,lib}/**/*"] + ["MIT-LICENSE", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.1"

  s.add_development_dependency "factory_girl_rails", "~> 4.0"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "specstar-controllers", "~> 0.0.5"
  s.add_development_dependency "specstar-models", "~> 0.0.6"
  s.add_development_dependency "specstar-support-random", "~> 0.0.1"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "webrat"
end
