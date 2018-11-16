# test_helper.rb
ENV['RACK_ENV'] = 'test'
where_rest_rb   = %x(find $PWD -name rest.rb).chomp
require 'minitest/autorun'
require 'rack/test'
require 'colorize'
require File.expand_path where_rest_rb, __FILE__

puts '* Test helper loaded'.green
