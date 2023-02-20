#load "kill_server.rb"
exec("rerun --dir . -- \"puma -C config/puma-local.rb\"")
