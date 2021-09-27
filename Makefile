## Meta data about the image
DOCKER_IMAGE=dsuite/alpine-php
DOCKER_IMAGE_CREATED=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKER_IMAGE_REVISION=$(shell git rev-parse --short HEAD)

## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

## Define latest versions
php_latest = 7.4
alpine_latest = 3.14

##
.DEFAULT_GOAL := help
.PHONY: *


help:
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

build-all: ## Build all supported versions
	@$(MAKE) build php=7.1 alpine=3.11
	@$(MAKE) build php=7.2 alpine=3.12
	@$(MAKE) build php=7.3 alpine=3.12
	@$(MAKE) build php=7.4 alpine=3.14

build: ## Build all images for a specific version of alpine-php ( usage : make build php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(eval alpine_version := $(or $(alpine),$(alpine_latest)))
	@$(MAKE) build-cli        php=$(php_version)  alpine=$(alpine_version)
	@$(MAKE) build-cli-dev    php=$(php_version)
	@$(MAKE) build-fpm        php=$(php_version)  alpine=$(alpine_version)
	@$(MAKE) build-fpm-dev    php=$(php_version)

build-cli: ## Build cli images for a specific version of alpine-php ( usage : make build-cli php=7.4 alpine=3.12 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(eval alpine_version := $(or $(alpine),$(alpine_latest)))
	@docker run --rm \
		-e DSUITE_IMAGE=alpine-base \
		-e DSUITE_VERSION=$(alpine_version) \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-base-$(php_version)"
	@docker build --no-cache --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-base-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-base \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e DSUITE_VERSION=$(php_version)-base \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.cli.template > Dockerfile-cli-$(php_version)"
	@docker build --no-cache --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-cli-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-cli \
		$(DIR)/Dockerfiles

build-cli-dev: ## Build cli-dev images for a specific version of alpine-php ( usage : make build-cli-dev php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@docker run --rm \
		-e DSUITE_VERSION=$(php_version)-cli \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.dev.template > Dockerfile-cli-dev-$(php_version)"
	@docker build --no-cache --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-cli-dev-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-cli-dev \
		$(DIR)/Dockerfiles

build-fpm: ## Build fpm images for a specific version of alpine-php ( usage : make build-fpm php=7.4 alpine=3.12 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(eval alpine_version := $(or $(alpine),$(alpine_latest)))
	@docker run --rm \
		-e DSUITE_IMAGE=alpine-base \
		-e DSUITE_VERSION=$(alpine_version) \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-fpm-base-$(php_version)"
	@docker build --no-cache --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-base-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-fpm-base \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e DSUITE_VERSION=$(php_version)-fpm-base \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.fpm.template > Dockerfile-fpm-$(php_version)"
	@docker build --no-cache --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-fpm \
		$(DIR)/Dockerfiles

build-fpm-dev: ## Build fpm-dev images for a specific version of alpine-php ( usage : make build-fpm-dev php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@docker run --rm \
		-e DSUITE_VERSION=$(php_version)-fpm \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.dev.template > Dockerfile-fpm-dev-$(php_version)"
	@docker build --no-cache --force-rm \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-dev-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-fpm-dev \
		$(DIR)/Dockerfiles

test: ## Test a specific version of alpine-php ( usage : make test php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@GOSS_FILES_PATH=$(DIR)/tests \
	GOSS_SLEEP=0.5 \
	 	dgoss run -e $(DOCKER_IMAGE):$(php_version)-fpm-dev

push-all: ## Push all  versions of alpine-php
	@$(MAKE) push php=7.1
	@$(MAKE) push php=7.2
	@$(MAKE) push php=7.3
	@$(MAKE) push php=7.4

push: ## Push a specific version of alpine-php ( usage : make push php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@docker push $(DOCKER_IMAGE):$(php_version)-cli
	@docker push $(DOCKER_IMAGE):$(php_version)-cli-dev
	@docker push $(DOCKER_IMAGE):$(php_version)-fpm
	@docker push $(DOCKER_IMAGE):$(php_version)-fpm-dev

remove: ## Remove all generated images
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi $(DOCKER_IMAGE):{}

readme: ## Generate docker hub full description
	@docker run -t --rm \
		-e DEBUG_LEVEL=DEBUG \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-v $(DIR):/data \
		dsuite/hub-updater

shell: ## Get a command prompt ( usage : make shell php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@docker run -it --rm \
		-e DEBUG_LEVEL=DEBUG \
		-e TIMEZONE=UTC \
 		-v $(DIR):/data \
		$(DOCKER_IMAGE):$(php_version)-fpm-dev \
		bash
