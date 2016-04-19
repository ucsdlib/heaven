# encoding: utf-8
set :application, 'deploybot'
set :repo_url, 'git@github.com:ucsdlib/deploybot.git'

set :deploy_to, '/pub/deploybot'
set :scm, :git

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'pids', 'node_modules')

set :default_env, fetch(:default_env, {}).merge('PATH' => "/pub/deploybot/current/node_modules/.bin:/pub/deploybot/current/node_modules/hubot/node_modules/.bin:$PATH")

namespace :deploy do
  desc "Sets up the log file, then sources EnvVars & starts Hubot"
  task :start do
    log_file = "#{shared_path}/log/hubot.log"
    # If we've got a log file already, mark that a deployment occurred
    on roles(:app) do
      execute "if [ -e #{log_file} ]; then echo \"\n\nDeployment #{release_timestamp}\n\" >> #{log_file}; fi"
      # Start Hubot!
      execute "source /home/conan/.bashrc && \
        cd #{release_path} && \
        forever start -p #{shared_path} --pidFile #{shared_path}/pids/hubot.pid -a -l #{shared_path}/log/hubot.log -c coffee node_modules/.bin/hubot -a slack -d"
    end
  end

  desc "Stop Hubot"
  task :stop do
    on roles(:app) do
      test "source /home/conan/.bashrc && \
        cd /pub/deploybot/current && \
        forever stop $(cat #{shared_path}/pids/hubot.pid)"
    end
  end

  desc "Install necessary Node modules, then move them to the correct path"
  task :npm_install do
    on roles(:app) do
      execute "cd #{release_path} && npm install"
    end
  end

  desc "Base task to restart Hubot after a deployment if he's already running"
  task :restart do
    invoke "deploy:stop"
    invoke "deploy:start"
  end
end
after "deploy:published", "deploy:restart"
before "deploy:updated", "deploy:npm_install"