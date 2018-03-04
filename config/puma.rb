#本番環境aws
_proj_path = "#{File.expand_path("../..", __FILE__)}"
_proj_name = File.basename(_proj_path)
_home = ENV.fetch("HOME") { "/home/naoki" }
pidfile "#{_home}/run/#{_proj_name}.pid"
bind "unix://#{_home}/run/#{_proj_name}.sock"
directory _proj_path
