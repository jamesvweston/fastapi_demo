.DEFAULT_GOAL := help

compose_file=.deploy/docker-compose.yml
dc_conf=--env-file .env --file $(compose_file) --project-directory .
dc_api_service=api
sqlgen_dataclasses=sqlacodegen postgresql://asdf:asdf@asdf-db/asdf --outfile stuff.py --generator dataclasses

.PHONY: help
help: ## displays help for all make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker-build: ## Build the Dockerfile
	docker-compose $(dc_conf) build --no-cache

docker-run: ## Run the local environment
	docker-compose $(dc_conf) up -d

docker-down: ## Bring the local environment down
	docker-compose $(dc_conf) down

dataclasses: ## Generates sqlalchemy dataclasses from database schema
	docker-compose $(dc_conf) exec $(dc_api_service) bash -c "$(sqlgen_dataclasses)"

black:
	docker-compose $(dc_conf) exec $(dc_api_service) bash -c "poetry run black ./asdf"

autoflake:
	docker-compose $(dc_conf) exec $(dc_api_service) bash -c "poetry run autoflake --recursive --in-place --remove-all-unused-imports --remove-duplicate-keys ./asdf"

isort:
	docker-compose $(dc_conf) exec $(dc_api_service) bash -c "poetry run isort ./asdf"

mypy:
	docker-compose $(dc_conf) exec $(dc_api_service) bash -c "poetry run mypy ./asdf"

flake8:
	docker-compose $(dc_conf) exec $(dc_api_service) bash -c "poetry run flake8 --count ./asdf"
