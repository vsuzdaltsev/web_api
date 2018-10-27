# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
where_rest_rb   = `find $PWD -name rest.rb`.chomp
require 'rspec'
require 'minitest/autorun'
require 'rack/test'
require 'colorize'
require File.expand_path(where_rest_rb, __FILE__)

puts '* Spec helper loaded'.green
