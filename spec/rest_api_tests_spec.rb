#!/usr/bin/env ruby

require File.expand_path('../spec_helper.rb', __FILE__)
include Rack::Test::Methods

def app
  RestApi
end

describe 'post_create_future_route' do
  it 'should successfully return default response from the route' do
    post "#{WebApiConf::DEFAULTS[:api_url_base_v1]}/post_create_future"
    expect(last_response).to be_ok
    puts "LAST: #{last_response.body}"
    last_response.body.include? "{\"method_name\":\"post_create_future\",\"future\":\"no future\"}\n"
  end
end

describe 'create_default_route_methods' do
  it 'should successfully return default response from default route' do
    WebApiConf::DEFAULTS[:valid_http_methods].each do |method|
      send(method, "#{WebApiConf::DEFAULTS[:api_url_base_v1]}/*") do
        expect(last_response).to be_ok
        last_response.body.include? "{\"help\":\"#{method} method default route\"}\n"
      end
    end
  end
end
