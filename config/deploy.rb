set :application, "wordpress-workflow"
set :repo_url, "git@github.com:DrewDahlman/wordpress-workflow.git"
set :user, 'www-data'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Set Sudo
set :use_sudo, false

set :linked_dirs, %w{node_modules wordpress/wp-content/uploads wordpress/wp-content/plugins}

#--------------------------------------------------------------
#
#   On Deploy run NPM and build.
#
#--------------------------------------------------------------
namespace :deploy do

  desc 'Restart application'
  task :build do
    on roles(:app), in: :sequence, wait: 1 do
      set :current_path, "#{fetch(:deploy_to)}/current"

      execute "cd #{fetch(:current_path)} && mv build-files/* #{fetch(:current_path)}"
      execute "cd #{fetch(:current_path)} && npm install"
      execute "cd #{fetch(:current_path)} && gulp dist -e production"
    end
  end

  after :updated, :restart
end
