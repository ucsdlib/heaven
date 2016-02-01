# encoding: utf-8
set :application, 'deploybot'
set :repo_url, 'git@github.com:ucsdlib/deploybot.git'

set :deploy_to, '/pub/deploybot'
set :scm, :git

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'pids', 'node_modules')

set :default_env, fetch(:default_env, {}).merge('PATH' => "/pub/deploybot/current/node_modules/.bin:/pub/deploybot/current/node_modules/hubot/node_modules/.bin:$PATH")
namespace :deploy do

  desc "Install npm"
  task :npm_install do
    on roles(:app) do
      execute "cd #{release_path} && npm install"
    end
  end
  
  desc 'Restart Hubot'
  task :restart do
    log_file = "#{shared_path}/log/hubot.log"
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute "if [ -e #{log_file} ]; then echo \"\n\nDeploy #{release_timestamp}\n\" >> #{log_file}; fi"      
      # Stop Hubot
      test "source /home/deploy/.bashrc && cd /pub/deploybot/current && forever stop $(cat #{shared_path}/pids/hubot.pid)"       
      # Start Hubot
      execute "source /home/deploy/.bashrc && cd #{release_path} && \
        forever start -p #{shared_path} --pidFile #{shared_path}/pids/hubot.pid -a -l #{shared_path}/log/hubot.log -c coffee node_modules/.bin/hubot -a slack -d"
    end
  end

  after :finishing, 'deploy:npm_install'
  after :finishing, 'deploy:restart'
end
