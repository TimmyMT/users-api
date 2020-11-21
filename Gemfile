# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'puma', '~> 4.1'
gem 'rack-cors'

gem 'jwt'
gem 'jbuilder', '~> 2.7'
gem 'slim-rails', '~> 3.2'
gem 'letter_opener', '~> 1.7.0'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0'
  gem 'pronto'
  gem 'pronto-brakeman', '~> 0.10.0'
  gem 'pronto-flay', require: false
  gem 'pronto-rubocop', require: false
  gem 'rubocop', require: false
  gem 'pry'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'ffaker'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
