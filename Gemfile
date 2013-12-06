source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.2'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass', '~> 2.3.2.2'
gem 'simple_form'
gem 'thin'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'hirb'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'rails_layout'
  gem 'pry-rails'
end
group :development, :test do
  gem 'rspec-rails'
end
group :test do
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end
