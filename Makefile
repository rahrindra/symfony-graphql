
DOCKER_COMPOSE = docker compose
PHP = $(DOCKER_COMPOSE) exec php
COMPOSER = $(PHP) composer
CONSOLE = $(PHP) php bin/console

## —— 🚀 Docker —————————————————————————————————————
build: ## Démarrer les containers
	$(DOCKER_COMPOSE) up -d --build
.PHONY: build

start: ## Démarrer les containers
	$(DOCKER_COMPOSE) up -d
.PHONY: start

stop: ## Arrêter les containers
	$(DOCKER_COMPOSE) stop
.PHONY: stop

restart: ## Redémarrer les containers
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) up -d
.PHONY: restart

logs: ## Voir les logs
	$(DOCKER_COMPOSE) logs -f
.PHONY: logs

ps: ## Voir les containers
	$(DOCKER_COMPOSE) ps
.PHONY: ps

## —— 📦 Installation ——————————————————————————————
install: ## Installer le projet Symfony (composer install)
	$(COMPOSER) install
.PHONY: install

init: ## Initialisation complète projet
	$(DOCKER_COMPOSE) up -d --build
	$(COMPOSER) install
.PHONY: init

## —— 🎯 Symfony ————————————————————————————————
cc: ## Clear cache
	$(CONSOLE) cache:clear
.PHONY: cc

clean: ## Nettoie les caches et fichiers temporaires
	@echo "$(GREEN)🧹 Nettoyage des caches...$(NC)"
	docker compose exec php rm -rf var/cache/*
	docker compose exec php rm -f .php-cs-fixer.cache
	docker compose exec php rm -rf .build/phpstan/cache/*
	@echo "$(GREEN)✅ Nettoyage terminé !$(NC)"
.PHONY: clean

migrate: ## Migrations
	$(CONSOLE) doctrine:migrations:migrate --no-interaction
.PHONY: migrate

## —— 🗄️ Base de données ————————————————————————
db-create: ## Créer la DB
	$(CONSOLE) doctrine:database:create
.PHONY: db-create

db-reset: ## Reset DB
	$(CONSOLE) doctrine:database:drop --force --if-exists
	$(CONSOLE) doctrine:database:create
	$(CONSOLE) doctrine:migrations:migrate --no-interaction
.PHONY: db-reset

## —— 🧹 Clean ——————————————————————————————————————
down: ## Supprimer containers + réseau
	$(DOCKER_COMPOSE) down
.PHONY: down

# DEFAULT
.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help
