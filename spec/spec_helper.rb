require 'coveralls'
Coveralls.wear_merged!

require 'rack/test'
require 'database_cleaner'
require 'action_controller'

require 'odi_members'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.order = :random

  include Rack::Test::Methods
  def app
    OdiMembers::App
  end
end

def http_auth
  ActionController::HttpAuthentication::Basic.encode_credentials(
    ENV['MEMBERS_API_USERNAME'],
    ENV['MEMBERS_API_PASSWORD']
  )
end
