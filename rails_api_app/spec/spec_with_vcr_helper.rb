require 'vcr'

VCR.configure do |c|
  c.hook_into :faraday
  c.default_cassette_options = {
    :record => :once,
    :allow_unused_http_interactions => false,
    :match_requests_on => [:method, :uri, :body]
  }
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = 'spec/cassettes'
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.around do |example|

    # Just disable the VCR, the configuration for its usage
    # will be done in a shared_context
    if example.metadata[:vcr]
      example.run
    else
      VCR.turned_off { example.run }
    end
  end
end

require 'spec_helper'
