## WEB API

### USAGE

Make sure that:
 - dockerd is running on the localhost
 - rake gem is installed (gem install rake)
 - docker-compose is installed
 - git client is installed
 
```
git clone https://anonymus88@bitbucket.org/anonymus88/web_api.git .
cd web_api
bundle install
bundle exec rake docker_compose:build
bundle exec rake docker_compose:run
curl 127.0.0.1:4567/api/v1/some_request

bundle exec rake docker_compose:stop
```
