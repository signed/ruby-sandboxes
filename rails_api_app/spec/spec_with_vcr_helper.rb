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

require 'spec_helper'
