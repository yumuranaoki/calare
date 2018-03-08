_proj_path = "#{File.expand_path("../../..", __FILE__)}"
_proj_name = File.basename(_proj_path)
_home = ENV.fetch("HOME") { "/home/naoki" }
pidfile "#{_proj_path}/tmp/pids/puma.pid"
bind "unix://#{_proj_path}/tmp/sockets/puma.sock"
directory _proj_path

workers 2
threads 5, 5

preload_app!