load "kill_server.rb"

exec("puma -C config/puma-local.rb &")
puts "Puma server restarted."