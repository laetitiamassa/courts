source 'https://rubygems.org'
ruby '2.2.3'


gem 'rails', '4.2.4'
gem 'devise', '~> 3.5.2'
gem 'devise_invitable', '~> 1.5.2'
gem 'activeadmin', github: 'activeadmin'

gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem 'aws-sdk', '< 2.0' #as future version have some incompatibilities

gem 'sass-rails', '~> 4.0.0'

gem 'bootstrap-sass', '3.1.1.0'
#gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails',
                              #:git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'mailjet'
gem 'sendgrid'
gem 'roadie-rails', '~> 1.0'

gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

group :development, :test do
     gem 'sqlite3'
end

group :production do
     gem 'pg'
     gem 'rails_12factor'
end

group :staging do
    gem 'pg'
    gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

