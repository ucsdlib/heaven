# encoding: utf-8
set :stage, :production
set :branch, 'master'
server 'lib-hydrahead-prod.ucsd.edu', user: 'conan', roles: %w{web app db}