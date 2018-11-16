#!/usr/bin/env ruby

load 'config/conf.rb'

require 'json'
require 'sinatra/base'
require 'sinatra/streaming'

class RestApi < Sinatra::Base
  include WebApiConf

  helpers Sinatra::Streaming
  set(:views, 'views')

  Valid_http_methods = WebApiConf::DEFAULTS[:valid_http_methods]
  Api_url_base_v1    = WebApiConf::DEFAULTS[:api_url_base_v1]

  def self.create_rest_api
    post_create_future
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
            help = [] << {help: "#{m} method default route"}.to_json
            out.puts help.join("\n")
          end
        end
      end
    end
  end

  def self.post_create_future
    method = __method__
    post "#{Api_url_base_v1}/#{method}" do
      stream do |out|
        content_type(:json)
        output = proc do |e|
          { method_name: method,
            future:      e
          }.to_json
        end
        begin
          req = JSON.parse(request.body.read)
          out.puts output.call(req)
        rescue
          out.puts output.call(WebApiConf::DEFAULTS[:future])
        end
      end
    end
  end
end
