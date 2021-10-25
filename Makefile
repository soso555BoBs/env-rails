up:
	docker-compose up -d
build:
	docker-compose build --no-cache --force-rm
rails-install:
	docker-compose run app rails new . --force --database=postgresql --skip-bundle
bundle-install:
	docker-compose run --rm app bundle install
webpacker-install:
	docker-compose run --rm app rails webpacker:install
cp-db-config:
	cp ./infra/docker/ruby/database.yml ./backend/config/
create-project:
	mkdir -p backend
	@make rails-install
	@make cp-db-config
	@make build
	@make up
	@make bundle-install
	@make webpacker-install
	@make fresh
	@make restart
init:
	docker-compose up -d --build
	@make bundle-install
	@make restart
remake:
	@make destroy
	@make init
stop:
	docker-compose stop
down:
	docker-compose down --remove-orphans
restart:
	@make down
	@make up
destroy:
	docker-compose down --rmi all --volumes --remove-orphans
destroy-volumes:
	docker-compose down --volumes --remove-orphans
ps:
	docker-compose ps
logs:
	docker-compose logs
logs-watch:
	docker-compose logs --follow
log-web:
	docker-compose logs web
log-web-watch:
	docker-compose logs --follow web
log-app:
	docker-compose logs app
log-app-watch:
	docker-compose logs --follow app
log-db:
	docker-compose logs db
log-db-watch:
	docker-compose logs --follow db
web:
	docker-compose exec web ash
app:
	docker-compose exec app bash
fresh:
	docker-compose run --rm app rake db:create
test:
	docker-compose exec app php artisan test
npm:
	@make npm-install
npm-install:
	docker-compose exec app npm install
npm-dev:
	docker-compose exec app npm run dev
npm-watch:
	docker-compose exec app npm run watch
npm-watch-poll:
	docker-compose exec app npm run watch-poll
npm-hot:
	docker-compose exec app npm run hot
yarn:
	docker-compose exec app yarn
yarn-install:
	@make yarn
yarn-dev:
	docker-compose exec app yarn dev
yarn-watch:
	docker-compose exec app yarn watch
yarn-watch-poll:
	docker-compose exec app yarn watch-poll
yarn-hot:
	docker-compose exec app yarn hot
db:
	docker-compose exec db bash
sql:
	docker-compose exec db bash -c 'psql "postgresql://$$POSTGRES_USER:$$POSTGRES_PASSWORD/@localhost:5432/$$POSTGRES_DB"'
redis:
	docker-compose exec redis redis-cli
