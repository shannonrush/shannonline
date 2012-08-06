# The name of your app
set :application, "shannonline"
# The directory on the EC2 node that will be deployed to
set :deploy_to, "/srv/www/shannonline"
# The type of Source Code Management system you are using
set :scm, :git
# The location of the LOCAL repository relative to the current app
set :repository,  "git://github.com/shannonrush/shannonline.git"
# The way in which files will be transferred from repository to remote host
# If you were using a hosted github repository this would be slightly different
# set :deploy_via, :copy

# The address of the remote host on EC2 (the Public DNS address)
set :location, "li96-150.members.linode.com"
# setup some Capistrano roles
role :app, location
role :web, location
role :db,  location, :primary => true

# Set up SSH so it can connect to the EC2 node - assumes your SSH key is in ~/.ssh/id_rsa
set :user, "root"
set :use_sudo, false
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa_navi")]

namespace :deploy do  
  desc "Make symlink for smtp_gmail.yml" 
    task :symlink_smtp_gmail_yml do
      run "ln -nfs #{File.join(shared_path,'config','smtp_gmail.yml')} #{File.join(release_path,'config','smtp_gmail.yml')}"
    end
  
    desc "Create empty smtp_gmail.yml in shared path" 
    task :create_smtp_gmail_yml do
      run "mkdir -p #{shared_path}/config" 
      run "touch #{File.join(shared_path,'config','smtp_gmail.yml')}"
    end
    
    desc "Make symlink for environment.rb" 
      task :symlink_environment_rb do
        run "ln -nfs #{File.join(shared_path,'config', 'environment.rb')} #{File.join(release_path,'config','environment.rb')}"
      end

      desc "Create empty environment.rb in shared path" 
      task :create_environment_rb do
        run "mkdir -p #{shared_path}/config" 
        run "touch #{File.join(shared_path,'config','environment.rb')}"
      end
      
      desc "Make symlink for database.yml" 
        task :symlink_database_yml do
          run "ln -nfs #{File.join(shared_path,'config', 'database.yml')} #{File.join(release_path,'config','database.yml')}"
        end

        desc "Create empty database.yml in shared path" 
        task :create_database_yml do
          run "mkdir -p #{shared_path}/config" 
          run "touch #{File.join(shared_path,'config','database.yml')}"
        end
      
    
      set :monit_group, 'shannonline' 
      
      desc "Restart the Mongrel processes on the app server by calling restart_mongrel_cluster." 
    
      task :restart, :roles => :app do 
        restart_mongrel_cluster 
      end 
      
      desc "Start Mongrel processes on the app server."
      task :start_mongrel_cluster , :roles => :app do 
         run "/usr/sbin/monit start all -g #{monit_group}" 
      end 

      desc "Restart the Mongrel processes on the app server by starting and stopping the cluster." 
      task :restart_mongrel_cluster , :roles => :app do 
         run "/usr/sbin/monit restart all -g #{monit_group}" 
      end 
      
      desc "Stop the Mongrel processes on the app server."
      task :stop_mongrel_cluster , :roles => :app do 
         run "/usr/sbin/monit stop all -g #{monit_group}" 
      end
      
  # after 'deploy:setup', 'deploy:create_db2s3'
  after 'deploy:setup', 'deploy:create_environment_rb'
  after 'deploy:setup', 'deploy:create_smtp_gmail_yml'
  after 'deploy:setup', 'deploy:create_database_yml'
  # after 'deploy:update_code', 'deploy:symlink_db2s3'
  after 'deploy:update_code', 'deploy:symlink_environment_rb'
  after 'deploy:update_code', 'deploy:symlink_smtp_gmail_yml'
  after 'deploy:update_code', 'deploy:symlink_database_yml'
end
  