set :stage, :production

server '207.154.226.131', user: 'otaman', roles: %w{web app db docker}

namespace :custom do
  task :setup_container do
    on roles(:docker) do |host|
      image_name = "runlviv" #we use this for container name also
      puts "================Starting Docker setup===================="
      # execute "cp #{deploy_to}/database.yml #{deploy_to}/current/config/database.yml"
      # execute "cp #{deploy_to}/secrets.yml #{deploy_to}/current/config/secrets.yml"
      execute "cd #{deploy_to}/current && docker build --rm=true --no-cache=false ."
      execute "docker stop #{image_name}; echo 0"
      execute "docker rm -fv #{image_name}; echo 0"
      execute 'docker run -tid -p 80:80 --name runlviv /runlviv'
      execute "docker exec -it runlviv bundle exec rake db:migrate"
    end
  end
end

after 'deploy:finishing', 'custom:setup_container'
