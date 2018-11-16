#!/usr/bin/env ruby

require File.expand_path('../test_helper.rb', __FILE__)
include Rack::Test::Methods

def app
  RestApi
end

describe 'post_create_future_route' do
  it 'should successfully return default response from the route' do
    post "#{$defaults[:api_url_base_v1]}/post_create_future"
    assert last_response.ok?
    last_response.body.must_include "{\"method_name\":\"post_create_future\",\"future\":\"no future\"}\n"
  end
end

describe 'create_default_route_methods' do
  it 'should successfully return default response from default route' do
    $defaults[:valid_http_methods].each do |method|
      send(method, "#{$defaults[:api_url_base_v1]}/*") do
        assert last_response.ok?
        last_response.body.must_include "{\"help\":\"#{method} method default route\"}\n"
      end
    end
  end
end
