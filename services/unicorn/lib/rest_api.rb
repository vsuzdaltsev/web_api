#!/usr/bin/env ruby
# frozen_string_literal: true

load    'config/conf.rb'
require 'json'
require 'sinatra/base'
require 'sinatra/streaming'

# Api class
class RestApi < Sinatra::Base
  include WebApiConf

  helpers Sinatra::Streaming
  set(:views, 'views')

  Valid_http_methods = WebApiConf::DEFAULTS[:valid_http_methods]
  Api_url_base_v1    = WebApiConf::DEFAULTS[:api_url_base_v1]

  def self.tests
    get '/api/v1/mkdate/Ymd' do
     Time.now.strftime("%Y%M%d")
    end
  end

  def self.create_rest_api
    tests
    create_default_route_methods(Valid_http_methods).each do |http_method|
      send("create_#{http_method}_default_route")
    end
  end

  def self.create_default_route_methods(http_methods)
    http_methods.each do |m|
      define_singleton_method("create_#{m}_default_route") do
        send(m, '/*') do
          stream do |out|
            content_type :json
            help = [] << { help: "#{m} method default route" }.to_json
            out.puts help.join("\n")
          end
        end
      end
    end
  end
end
