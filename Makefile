d:
	docker-compose down

u:
	make d && docker-compose up -d mysql nginx php-fpm workspace

b:
	docker-compose exec --user laradock workspace bash