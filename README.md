## WEB API

### USAGE

Make sure that:
 - dockerd is running on the localhost
 - rake gem is installed (gem install rake)
 - docker-compose is installed
 - git client is installed
 
```
git clone https://github.com/vsuzdaltsev/web_api.git .
cd web_api
rake docker_compose:build
rake docker_compose:run
curl 127.0.0.1:88/api/v1/some_request
tail -f  /var/log/unicorn.log

rake docker_compose:stop

```
