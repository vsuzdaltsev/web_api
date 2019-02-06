#!/usr/bin/env ruby

module WebApiConf
  where_gemfile = %x{find $PWD -name Gemfile}.chomp
  DEFAULTS = {
    future: 'no future',
    valid_http_methods: %w[
      delete
      get
      patch
      post
      put
    ],
    api_url_base_v1: '/api/v1'
  }.freeze
  DOCKER = {
    network_mode: 'host',
    env_file:     '.env'
  }.freeze
  UNICORN = {
    working_dir:    '/opt/app',
    ruby_ver:       IO.readlines(where_gemfile).grep(/ruby /).join.scan(/\d/).join('.'),
    host:           '127.0.0.1',
    port:           '4567',
    timeout:        '5',
    workers:        '2',
    log_vol:        '/var/log/:/opt/app/web_api/log',
    container_name: 'unicorn'
  }.freeze
  NGINX = {
    host:           '0.0.0.0',
    port:           '88',
    container_name: 'nginx'
  }.freeze
end
