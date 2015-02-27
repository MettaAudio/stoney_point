ruby '2.1.5'
source 'https://rubygems.org'
gem 'rails', '~> 4.1'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'bootstrap-sass'
gem 'simple_form', '>= 3.1.0.rc2'
gem 'thin'
gem 'devise'
gem 'slim'
gem 'chosen-sass-bootstrap-rails'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'hirb'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :mri_21, :rbx]
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
