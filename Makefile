-include .env


# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec php

# Executables
PHP      = $(PHP_CONT) php
COMPOSER = $(PHP_CONT) composer
SYMFONY  = $(PHP) bin/console

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build up start down logs sh composer vendor sf cc test install init_hooks phpstan-dry-run phpstan-fix phpunit tests qa

## —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build_no_cache: ## Builds the Docker images without using cache
	@$(DOCKER_COMP) build --pull --no-cache

build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --detach

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

sh: ## Connect to the PHP container
	@$(PHP_CONT) sh

bash: ## Connect to the PHP container via bash so up and down arrows go to previous commands
	@$(PHP_CONT) bash

test: ## Start tests with phpunit, pass the parameter "c=" to add options to phpunit, example: make test c="--group e2e --stop-on-failure"
	@$(eval c ?=)
	@$(DOCKER_COMP) exec -e APP_ENV=test php bin/phpunit $(c)


## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --no-interaction
vendor: composer

install: start vendor init_hooks

### —— Git 🌲 ———————————————————————————————————————————————————————————————————
#init_hooks: ## Initialize Git hooks, or check if an update is available.
#	./scripts/init-git-hooks.sh

## —— Quality Assurance (QA) 🛡️ ————————————————————————————————————————————————
# Executables
PHP_CS_FIXER = $(PHP_CONT) ./vendor/bin/php-cs-fixer
PHPSTAN = $(PHP_CONT) ./vendor/bin/phpstan
PHPUNIT = $(PHP_CONT) ./vendor/bin/phpunit

cs: ## Execute PHP CS Fixer all over the edited files contained in the `src` directory.
	@$(PHP_CS_FIXER) fix

phpstan: ## Execute PHPStan to analyse the codebase (without fixing files).
	@$(PHPSTAN) analyse

tests: phpunit

qa: phpstan cs tests

phpunit: ## Execute unit tests.
	@$(PHPUNIT) tests/

coverage: ## Generate an HTML code coverage report with PHPUnit
	@$(DOCKER_COMP) exec -e XDEBUG_MODE=coverage php ./vendor/bin/phpunit --coverage-html build/coverage
	@echo "✅ Code coverage report generated in build/coverage/"

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

cc: c=c:c ## Clear the cache
cc: sf

## —— Apache 🪶 ————————————————————————————————————————————————————————————————
open:
	@nohup xdg-open "http://localhost:$(APACHE_PORT)/api" > /dev/null 2>&1 &