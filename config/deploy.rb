# The name of your app
set :application, "shannonline"
# The directory on the EC2 node that will be deployed to
set :deploy_to, "/home/webuser/shannonline/"
# The type of Source Code Management system you are using
set :scm, :git
# The location of the LOCAL repository relative to the current app
set :repository,  "git://github.com/shannonrush/shannonline.git"
# The way in which files will be transferred from repository to remote host
# If you were using a hosted github repository this would be slightly different
# set :deploy_via, :copy

# The address of the remote host on EC2 (the Public DNS address)
set :location, "ec2-174-129-39-176.compute-1.amazonaws.com"
# setup some Capistrano roles
role :app, location
role :web, location
role :db,  location, :primary => true

# Set up SSH so it can connect to the EC2 node - assumes your SSH key is in ~/.ssh/id_rsa
set :user, "root"
set :use_sudo, false
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa-gsg-keypair")]

namespace :deploy do
  desc "Make symlink for db2s3.rb" 
    task :symlink_db2s3 do
      run "ln -nfs #{File.join(shared_path,'config','initializers','db2s3.rb')} #{File.join(release_path,'config','initializers','db2s3.rb')}"
    end

    desc "Create empty db2s3.rb in shared path" 
    task :create_db2s3 do
      run "mkdir -p #{shared_path}/config" 
      run "mkdir -p #{shared_path}/config/initializers" 
      run "touch #{File.join(shared_path,'config','initializers','db2s3.rb')}"
    end
    
    desc "Make symlink for production.rb" 
      task :symlink_production_rb do
        run "ln -nfs #{File.join(shared_path,'config','environments','production.rb')} #{File.join(release_path,'config','environments','production.rb')}"
      end

      desc "Create empty production.rb in shared path" 
      task :create_production_rb do
        run "mkdir -p #{shared_path}/config" 
        run "mkdir -p #{shared_path}/config/environments" 
        run "touch #{File.join(shared_path,'config','environments','production.rb')}"
      end
    
    desc "restart"
    task :restart do
      run "#{release_path}/script/restart.sh"
    end
      
  after 'deploy:setup', 'deploy:create_db2s3'
  after 'deploy:setup', 'deploy:create_production_rb'
  after 'deploy:update_code', 'deploy:symlink_db2s3'
  after 'deploy:update_code', 'deploy:symlink_production_rb'
  after 'deploy:update_code', 'deploy:restart'
end
  