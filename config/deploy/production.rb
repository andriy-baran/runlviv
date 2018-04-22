set :stage, :production

server '46.101.131.156', user: 'otaman', roles: %w{web app db docker}

# namespace :custom do
#   task :setup_container do
#     on roles(:docker) do |host|
#       image_name = "runlviv" #we use this for container name also
#       puts "================Starting Docker setup===================="
#       # execute "cp #{deploy_to}/database.yml #{deploy_to}/current/config/database.yml"
#       # execute "cp #{deploy_to}/secrets.yml #{deploy_to}/current/config/secrets.yml"
#       execute "cd #{deploy_to}/current && docker build --rm=true --no-cache=false ."
#       execute "docker stop #{image_name}; echo 0"
#       execute "docker rm -fv #{image_name}; echo 0"
#       execute "docker exec -it runlviv bundle exec rake db:migrate"
#     end
#   end
# end

# after 'deploy:finishing', 'custom:setup_container'
namespace :deploy do
  desc "Initialize application"
  task :initialize do
    invoke 'composing:build'
    invoke 'composing:database:up'
    invoke 'composing:database:create'
    invoke 'composing:database:migrate'
  end

  after :published, :restart do
    invoke 'composing:restart:web'
    invoke 'composing:database:migrate'
  end

  before :finished, :clear_containers do
    on roles(:app) do
      execute "docker ps -a -q -f status=exited | xargs -r docker rm -v"
      execute "docker images -f dangling=true -q | xargs -r docker rmi -f"
    end
  end
end
