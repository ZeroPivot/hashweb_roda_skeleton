# frozen_string_literal: true

# require 'sinatra'
# require_relative './comic'
# rerun --dir cgmfs -- "puma -C config/puma-nginx.rb"
require 'rubygems'
require 'roda'
#require 'sinatra'

require File.expand_path 'hashweb.rb', __dir__
#require "/root/comicman-remote-modular-midscore/comic.rb"

#run Rack::URLMap.new("/" => CGMFS.new,
#                    "/gallery" => ComicMan.new)
run HashWeb.freeze.app