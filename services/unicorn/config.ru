# frozen_string_literal: true

require 'sinatra'

set     :env, :production
disable :run

require './web_api/rest.rb'

run RestApi
