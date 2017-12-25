# frozen_string_literal: true
lock '3.10.0'

set :repo_url,        'git@github.com:dctacademy/dct-complier-assessment.git'
set :user,            'deploy'

## Defaults:
# set :scm,           :git
# set :format,        :pretty
# set :log_level,     :debug

## Linked Files & Directories (Default None):
set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs,  %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets public/uploads)
set :bundle_binstubs, nil

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
