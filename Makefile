d:
	docker-compose down

u:
	make d && docker-compose up -d mysql nginx php-fpm workspace php-worker

b:
	docker-compose exec --user laradock workspace bash

ub:
	make u && make b