# Simple Role Syntax
# ==================
role :app, %w{www-data@staging.bottrainer.tech}

set :branch, "staging"
set :deploy_to, "/var/www/#{fetch(:application)}/staging"