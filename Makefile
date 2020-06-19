## Meta data about the image
DOCKER_IMAGE=dsuite/alpine-php
DOCKER_IMAGE_CREATED=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
DOCKER_IMAGE_REVISION=$(shell git rev-parse --short HEAD)

## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

## Define the latest version
latest = 7.4
alpine = 3.11
nginx = 1.18

##
.DEFAULT_GOAL := help
.PHONY: *


help:
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build all images for a specific version of alpine-php ( usage : make build v="7.4" )
	@$(eval version := $(or $(v),$(latest)))
	@$(MAKE) build-cli v=$(version)
	@$(MAKE) build-cli-dev v=$(version)
	@$(MAKE) build-fpm v=$(version)
	@$(MAKE) build-fpm-dev v=$(version)
	@$(MAKE) build-nginx-fpm v=$(version)

build-cli: ## Build cli images for a specific version of alpine-php ( usage : make build-cli v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_IMAGE=alpine-base \
		-e DSUITE_VERSION=$(alpine) \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-base-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-base-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-base \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.cli.template > Dockerfile-cli-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-cli-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-cli \
		$(DIR)/Dockerfiles

build-cli-dev: ## Build cli-dev images for a specific version of alpine-php ( usage : make build-cli-dev v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(version)-cli \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.dev.template > Dockerfile-cli-dev-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-cli-dev-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-cli-dev \
		$(DIR)/Dockerfiles

build-fpm: ## Build fpm images for a specific version of alpine-php ( usage : make build-fpm v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_IMAGE=alpine-runit \
		-e DSUITE_VERSION=$(alpine) \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-runit-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-runit-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-runit \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(version) \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.fpm.template > Dockerfile-fpm-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-fpm \
		$(DIR)/Dockerfiles

build-fpm-dev: ## Build fpm-dev images for a specific version of alpine-php ( usage : make build-fpm-dev v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(version)-fpm \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.dev.template > Dockerfile-fpm-dev-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-dev-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-fpm-dev \
		$(DIR)/Dockerfiles

build-nginx-fpm: ## Build fpm images for a specific version of alpine-php ( usage : make build-fpm v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_IMAGE=alpine-nginx \
		-e DSUITE_VERSION=$(nginx) \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-nginx-runit-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-nginx-runit-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-nginx-runit \
		$(DIR)/Dockerfiles
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DSUITE_VERSION=$(version)-nginx \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-e DOCKER_IMAGE_CREATED=$(DOCKER_IMAGE_CREATED) \
		-e DOCKER_IMAGE_REVISION=$(DOCKER_IMAGE_REVISION) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.fpm.template > Dockerfile-nginx-fpm-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-nginx-fpm-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-nginx-fpm \
		$(DIR)/Dockerfiles

test: ## Test a specific version of alpine-php ( usage : make test v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@$(MAKE) build-fpm-dev v=$(version)
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):$(version)-fpm-dev

push: ## Push a specific version of alpine-php ( usage : make test v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@docker push $(DOCKER_IMAGE):$(version)-cli
	@docker push $(DOCKER_IMAGE):$(version)-cli-dev
	@docker push $(DOCKER_IMAGE):$(version)-fpm
	@docker push $(DOCKER_IMAGE):$(version)-fpm-dev
	@docker push $(DOCKER_IMAGE):$(version)-nginx-fpm

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

shell: ## Get a command prompt ( usage : make shell v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@$(MAKE) build-fpm-dev v=$(version)
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e TIMEZONE=UTC \
 		-v $(DIR):/data \
		$(DOCKER_IMAGE):$(version)-fpm-dev \
		bash
