set :application, "ando"
# GIT OPTIONS

default_run_options[:pty] = true
set :use_sudo, true
set :scm, "git"
set :repository,  "git://github.com/ddemaree/ando_plus_plus.git"
set :scm_passphrase, "porkWALKER"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "practical"
set :domain, "beta.practical.cc"
server domain, :app, :web
role :db, domain, :primary => true

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/practical/apps/#{application}"

namespace :edge do
  desc "Symlink edge rails"
  task :symlink_rails do
    run "cd #{shared_path}/edge_rails && git pull"
    run "rm -rf #{current_path}/vendor/rails"
    run "cd #{current_path}/vendor && ln -s #{shared_path}/edge_rails rails"
  end
  after "deploy:update_code", "edge:symlink_rails"
end

namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end