# encoding: utf-8
set :stage, :pontos
set :branch, 'develop'
server 'pontos.ucsd.edu', user: 'conan', roles: %w{app db}