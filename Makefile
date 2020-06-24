## Meta data about the image
DOCKER_IMAGE=dsuite/alpine-php
DOCKER_IMAGE_CREATED=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKER_IMAGE_REVISION=$(shell git rev-parse --short HEAD)

## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

## Define latest versions
php_latest = 7.4
alpine_latest = 3.12
nginx_latest = 1.19

##
.DEFAULT_GOAL := help
.PHONY: *


help:
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

all: ## Build all supported versions
	@$(MAKE) build php=7.1  alpine=3.11  nginx=1.19
	@$(MAKE) build php=7.2  alpine=3.11  nginx=1.19
	@$(MAKE) build php=7.3  alpine=3.11  nginx=1.19
	@$(MAKE) build php=7.4  alpine=3.11  nginx=1.19

build: ## Build all images for a specific version of alpine-php ( usage : make build php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(eval alpine_version := $(or $(alpine),$(alpine_latest)))
	@$(eval nginx_version := $(or $(nginx),$(nginx_latest)))
	@$(MAKE) build-cli        php=$(php_version)  alpine=$(alpine_version)
	@$(MAKE) build-cli-dev    php=$(php_version)
	@$(MAKE) build-fpm        php=$(php_version)  alpine=$(alpine_version)
	@$(MAKE) build-fpm-dev    php=$(php_version)
	@$(MAKE) build-nginx-fpm  php=$(php_version)  alpine=$(alpine_version)  nginx=$(nginx_version)

build-cli: ## Build cli images for a specific version of alpine-php ( usage : make build-cli php=7.4 alpine=3.12 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(eval alpine_version := $(or $(alpine),$(alpine_latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_IMAGE=alpine-base \
		-e DSUITE_VERSION=$(alpine_version) \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-base-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-base-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-base \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.cli.template > Dockerfile-cli-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-cli-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-cli \
		$(DIR)/Dockerfiles

build-cli-dev: ## Build cli-dev images for a specific version of alpine-php ( usage : make build-cli-dev php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(php_version)-cli \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.dev.template > Dockerfile-cli-dev-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-cli-dev-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-cli-dev \
		$(DIR)/Dockerfiles

build-fpm: ## Build fpm images for a specific version of alpine-php ( usage : make build-fpm php=7.4 alpine=3.12 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(eval alpine_version := $(or $(alpine),$(alpine_latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_IMAGE=alpine-runit \
		-e DSUITE_VERSION=$(alpine_version) \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-runit-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-runit-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-runit \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(php_version) \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.fpm.template > Dockerfile-fpm-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-fpm \
		$(DIR)/Dockerfiles

build-fpm-dev: ## Build fpm-dev images for a specific version of alpine-php ( usage : make build-fpm-dev php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(php_version)-fpm \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.dev.template > Dockerfile-fpm-dev-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-dev-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-fpm-dev \
		$(DIR)/Dockerfiles

build-nginx-fpm: ## Build fpm images for a specific version of alpine-php ( usage : make build-fpm php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(eval alpine_version := $(or $(alpine),$(alpine_latest)))
	@$(eval nginx_version := $(or $(nginx),$(nginx_latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_IMAGE=alpine-nginx \
		-e DSUITE_VERSION=$(nginx_version) \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-nginx-runit-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-nginx-runit-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-nginx-runit \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(php_version)-nginx \
		-e ALPINE_VERSION=$(alpine_version) \
		-e PHP_VERSION=$(php_version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.fpm.template > Dockerfile-nginx-fpm-$(php_version)"
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-nginx-fpm-$(php_version) \
		--tag $(DOCKER_IMAGE):$(php_version)-nginx-fpm \
		$(DIR)/Dockerfiles

test: ## Test a specific version of alpine-php ( usage : make test php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(MAKE) build-fpm-dev php=$(php_version)
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):$(php_version)-fpm-dev

push: ## Push a specific version of alpine-php ( usage : make push php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@docker push $(DOCKER_IMAGE):$(php_version)-cli
	@docker push $(DOCKER_IMAGE):$(php_version)-cli-dev
	@docker push $(DOCKER_IMAGE):$(php_version)-fpm
	@docker push $(DOCKER_IMAGE):$(php_version)-fpm-dev
	@docker push $(DOCKER_IMAGE):$(php_version)-nginx-fpm

remove: ## Remove all generated images
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi $(DOCKER_IMAGE):{}

readme: ## Generate docker hub full description
	@docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-v $(DIR):/data \
		dsuite/hub-updater

shell: ## Get a command prompt ( usage : make shell php=7.4 )
	@$(eval php_version := $(or $(php),$(php_latest)))
	@$(MAKE) build-fpm-dev php=$(php_version)
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e TIMEZONE=UTC \
 		-v $(DIR):/data \
		$(DOCKER_IMAGE):$(php_version)-fpm-dev \
		bash
