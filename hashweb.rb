require 'roda'
require 'json'
require 'fileutils'
require 'fastimage'
require 'resolv'
require 'tzinfo'
#require_relative 'require_dir' # for route auto-loading
require_relative "require_dir"
require_relative "logger"
require_relative "lib/partitioned_array/lib/line_db"

SERVER_IP = "127.0.0.1"

class HashWeb < Roda
  PATHS_INCLUDE_CSRF = {'/api/lines' => true, '/api/lines/' => true}
  PARTITION_AMOUNT = 9 # The initial, + 1 
  OFFSET = 1 # This came with the math, but you can just state the PARTITION_AMOUNT in total and not worry about the offset in the end
  DB_SIZE = 20 # Caveat: The DB_SIZE is th # Caveat: The DB_SIZE is the total # of partitions, but you subtract it by one since the first partition is 0, in code.
  PARTITION_ADDITION_AMOUNT = 2
  plugin :render, :escape_html => false, :escape => false
  plugin :multi_route
  plugin :all_verbs
  plugin :hash_routes
  plugin :not_found
  plugin :slash_path_empty
  plugin :public
  plugin :shared_vars
  plugin :exception_page
  plugin :error_handler
  plugin :sessions, :secret => 'cgmfs3748w5yuieskrhfakgejgKAYUSGDYFHKGD&*R#at3wLKSGFHgfjgklsdfgjkl'
  plugin :route_csrf, :check_request_methods => ['POST'], :raise => true#, :check_header => false
  # Documentation: https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Assets.html
  # https://rubydoc.info/gems/roda-cj/1.0.3/Roda/RodaPlugins/Csrf
  plugin :assets, css: ['style.css'], js: ['script.js']
  #plugin :csrf, :raise=>true, :skip=>['POST:/api/screens']
  # <%= assets(:css) %>
 # <%= assets(:js) %>
 puts Dir.pwd
  require_dir './hashweb/routes'
  route do |r|
    #log("request path: #{r.path} ; request host: #{r.host}")
    #request_deflection(r) # deflects any request that uses the server's ip address directly to the domain name
    r.public
    r.assets # for public assets
    #log("route: #{r.path}")
    if r.path == PATHS_INCLUDE_CSRF[r.path] # Known bugs: if there is no slash at the end of the path, it will not work (will override check_csrf! checking)
      check_csrf!
    end
    r.hash_routes
 end
end

