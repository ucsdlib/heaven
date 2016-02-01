# encoding: utf-8
set :stage, :staging
set :branch, 'staging'
server 'lib-hydrahead-staging.ucsd.edu', user: 'conan', roles: %w{web app db sitemap_noping}
