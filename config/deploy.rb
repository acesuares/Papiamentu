set :application, ENV['DEPLOY_APPLICATION']
set :repo_url, ENV['DEPLOY_REPO_URL']
set :branch, ENV['DEPLOY_BRANCH']
set :bundle_binstubs, nil

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, ENV['DEPLOY_DIRECTORY']

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, [])
  .push("config/application.yml")
# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, [])
  .push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor/bundle", "public/uploads", "public/sitemaps")

# Default value for keep_releases is 5
set :keep_releases, 5

before :deploy, 'git:push'

before 'rvm1:install:rvm', 'app:update_rvm_key'
after 'rvm1:install:ruby', 'rvm1:install_bundler'

before 'deploy', 'rvm1:install:rvm'  # install/update RVM
before 'deploy', 'rvm1:install:ruby'  # install/update Ruby

before 'deploy:check', 'figaro:upload'
after 'deploy:publishing', 'deploy:restart'

# Restart unicorn
namespace :deploy do
  task :restart do
    invoke "unicorn:restart"
  end
end

# Uploads secrets.yml, database.yml and application.yml files
namespace :figaro do
  task :upload do
    on roles(:all) do
      execute "mkdir -p #{shared_path}/config"
      upload! 'config/application.yml', "#{shared_path}/config/application.yml"
    end
  end
end

namespace :app do
  task :update_rvm_key do
    roles(:all) do
      execute :gpg, "--keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
    end
  end
end

namespace :rvm1 do # https://github.com/rvm/rvm1-capistrano3/issues/45
  desc "Install Bundler"
  task :install_bundler do
    on release_roles :all do
      execute "cd #{release_path} && #{fetch(:rvm1_auto_script_path)}/rvm-auto.sh . gem install bundler"
    end
  end
end

namespace :git do
  desc 'Commiting and pushing to the remote repository'
  task :push do
    on roles(:all) do
      # run_locally do
      #   # Check for any local changes that haven't been committed
      #   status = %x(git status --porcelain).chomp
      #   if status != ""
      #     ask :answer, "Local git repository has uncommitted changes?. Continue deploying? [Y/N]"
      #     unless fetch(:answer).downcase.strip == 'y'
      #       puts "Deploy cancelled\n"
      #       exit
      #     end
      #   end
      #
      #   # Check we are on the master branch, so we can't forget to merge before deploying
      #   branch = %x(git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \\(.*\\)/\\1/').chomp
      #   if branch != "master" && !ENV["IGNORE_BRANCH"]
      #     raise RuntimeError, "Not on master branch (set IGNORE_BRANCH=1 to ignore)"
      #   end
      #
      #   system "bundle install"
      #   system "git commit -a"
      #   system "git push"
      # end
    end
  end
end
