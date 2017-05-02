build:
	docker-compose build

prepare:
	docker-sync start --daemon 2>/dev/null; true

install: bundle
	docker-compose run --rm web bundle exec rails db:setup

update: bundle migrate

migrate: prepare
	docker-compose run --rm web bundle exec rails db:migrate

seed: prepare
	docker-compose run --rm web bundle exec rails db:seed
reset: prepare
	docker-compose run --rm web bundle exec rails db:reset

routes: prepare
	docker-compose run --rm web bundle exec rake routes

bundle: prepare
	docker-compose run --rm web bash -c "bundle install && bundle exec rake tmp:cache:clear && yarn && npm rebuild node-sass && yarn run setup"

run: ntp prepare
	docker-compose run -e DOCKER_HOST_PATH=`pwd` -e DOCKER_HOST_USER=`whoami` --rm --service-ports web

console: ntp prepare
	docker-compose run -e DOCKER_HOST_PATH=`pwd` -e DOCKER_HOST_USER=`whoami` --rm web bundle exec rails console

c: console

ntp:
	docker-compose -f dockerfiles/docker-compose-ntp.yml run -e DOCKER_HOST_DATE=`date -u +%m%d%H%M%Y` --rm web

rspec: prepare
	docker-compose run --rm web bash -c "RAILS_ENV='test' bundle exec rspec"

guard: prepare
	docker-compose run --rm web bash -c "RAILS_ENV='test' bundle exec guard"

stop:
	docker-compose stop

uninstall: stop
	docker-compose rm

shell: prepare
	docker-compose run -e DOCKER_HOST_PATH=`pwd` -e DOCKER_HOST_USER=`whoami` --rm web bash

run-daemon:
	docker-compose up -d

deploy: prepare
	docker-compose run --rm web bundle exec cap -t development deploy

