#!/usr/bin/env ruby

require File.expand_path('../spec_helper.rb', __FILE__)
include Rack::Test::Methods

def app
  RestApi
end

describe 'post_create_future_route' do
  context 'when curl post_create_future' do
    it 'should successfully return default response from the route' do
      post "#{WebApiConf::DEFAULTS[:api_url_base_v1]}/post_create_future"
      expect(last_response).to be_ok
      last_response.body.include? "{\"method_name\":\"post_create_future\",\"future\":\"no future\"}\n"
    end
  end
end

describe 'create_default_route_methods' do
  context 'when curl different http types' do
    it 'should successfully return default response from default route with http type' do
      WebApiConf::DEFAULTS[:valid_http_methods].each do |method|
        send(method, "#{WebApiConf::DEFAULTS[:api_url_base_v1]}/*") do
          expect(last_response).to be_ok
          last_response.body.include? "{\"help\":\"#{method} method default route\"}\n"
        end
      end
    end
  end
end
