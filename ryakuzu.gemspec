$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ryakuzu/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ryakuzu'
  s.version     = Ryakuzu::VERSION
  s.authors     = ['ID25']
  s.email       = ['xid25x@gmail.com']
  s.homepage    = 'https://github.com/ID25/ryakuzu'
  s.summary     = 'Ryakuzu helps you to manage your schema.rb'
  s.description = 'Ryakuzu - Interface for your schema.rb'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 3.1.0'
  s.add_dependency 'jquery-rails', '>= 3.1.0'
  s.add_dependency 'virtus'
  s.add_dependency 'slim-rails'
  s.add_dependency 'virtus-relations'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
end
