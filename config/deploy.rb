set :user, 'goalyzer3'  # Your dreamhost account's username
set :domain, 'goalyzer.com'  # Dreamhost servername where your account is located 
set :project, 'goalyzer.com'  # Your application as its called in the repository
set :application, 'goalyzer.com'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

# version control config
set :scm, 'git'
set :repository,  "git@github.com:marcosnogueira/ticket.git"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
ssh_options[:keys] = ['~/.ssh/id_dsa']            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

namespace :deploy do
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :after_update_code  do
    #run "cp #{shared_path}/database.yml #{release_path}/config/."
    #run "ln -nfs #{shared_path}/system #{release_path}/public/system"
  end
  
end