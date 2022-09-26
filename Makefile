.PHONY: rebuild up shell migrate down

rebuild:
	docker-compose up --no-deps --force-recreate --build -d web

up:
	docker-compose --env-file .env.example up

shell:
	docker-compose exec web python manage.py shell

migrate:
	docker-compose exec web python manage.py migrate

down:
	docker-compose down
