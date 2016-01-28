ruby "2.2.3"
source "https://rubygems.org"

gem "rails",    "~>4.2.2"
gem "resque"
gem "resque-lock-timeout"
gem "octokit"
gem "unicorn"
gem "yajl-ruby"
gem "posix-spawn"
gem "warden-github-rails"
gem "faraday"
gem "faraday_middleware"

# Providers
gem "dpl",        "1.5.7"
gem "aws-sdk"
#gem "capistrano", "2.9.0"

# Deploy with Capistrano
gem 'capistrano', '~> 3.4.0'
gem 'capistrano-rails', '~> 1.1.6'
gem 'capistrano-rbenv', '~> 2.0.4'
gem 'capistrano-bundler'

# Notifiers
gem "hipchat"
gem "campfiyah"
gem "slack-notifier"
gem "flowdock"

group :test do
  gem "sqlite3", "1.3.10"
  gem "webmock"
  gem "simplecov", "0.7.1"
  gem "rubocop"
  gem "rspec-rails"
end

group :development do
  gem "pry"
  gem "foreman"
  gem "meta_request"
  gem "better_errors"
  gem "binding_of_caller"
end

group :staging, :production do
  gem "pg"
  gem "rails_12factor"
end
