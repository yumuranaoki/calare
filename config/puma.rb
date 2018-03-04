
env = ENV.fetch("RAILS_ENV") { "development" }
environment = env


#本番環境aws
if env == "production"
  _proj_path = "#{File.expand_path("../..", __FILE__)}"
  _proj_name = File.basename(_proj_path)
  _home = ENV.fetch("HOME") { "/home/naoki" }
  pidfile "#{_home}/run/#{_proj_name}.pid"
  bind "unix://#{_home}/run/#{_proj_name}.sock"
  directory _proj_path
else
  port ENV.fetch("PORT") { 3000 }
end
