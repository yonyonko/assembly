build:
	docker-compose build

prepare:
	docker-sync start --daemon 2>/dev/null; true

install: bundle
	docker-compose run --rm web bundle exec rake db:setup

update: bundle migrate

migrate: prepare
	docker-compose run --rm web bundle exec rake db:migrate

reset: prepare
	docker-compose run --rm web bundle exec rake db:reset

bundle: prepare
	docker-compose run --rm web bash -c bundle install

run: ntp prepare
	docker-compose run -e DOCKER_HOST_PATH=`pwd` -e DOCKER_HOST_USER=`whoami` --rm --service-ports web

console: ntp prepare
	docker-compose run -e DOCKER_HOST_PATH=`pwd` -e DOCKER_HOST_USER=`whoami` --rm web bundle exec rake console

c: console

shell: ntp prepare
	docker-compose run -e DOCKER_HOST_PATH=`pwd` -e DOCKER_HOST_USER=`whoami` --rm web bash

ntp:
	docker-compose -f dockerfiles/docker-compose-ntp.yml run -e DOCKER_HOST_DATE=`date -u +%m%d%H%M%Y` --rm web

stop:
	docker-compose stop

uninstall: stop
	docker-compose rm
