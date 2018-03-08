# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "calare"
set :repo_url, "git@github.com:yumuranaoki/calare.git"
set :deploy_to, "/var/www/rails/calare"
set :rbenv_ruby, "2.5.0"
set :log_level, :debug
set :keep_releases, 3
set :linked_files, fetch(:linked_files, []).push('config/secret.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :deploy do
    desc 'Restart application'
    task :restart do
      invoke 'puma:restart'
    end
  
    desc 'Create database'
    task :db_create do
      on roles(:db) do |host|
        with rails_env: fetch(:rails_env) do
          within current_path do
            execute :bundle, :exec, :rake, 'db:create'
          end
        end
      end
    end
  
    desc 'Run seed'
    task :seed do
      on roles(:app) do
        with rails_env: fetch(:rails_env) do
          within current_path do
            execute :bundle, :exec, :rake, 'db:seed'
          end
        end
      end
    end
  
    after :publishing, :restart
  
    after :restart, :clear_cache do
      on roles(:web), in: :groups, limit: 3, wait: 10 do
      end
    end
  end
