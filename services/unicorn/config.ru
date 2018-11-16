require 'sinatra'

set     :env, :production
disable :run

require './web_api/rest.rb'

run RestApi
