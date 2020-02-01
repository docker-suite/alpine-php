## Name of the image
DOCKER_IMAGE=dsuite/alpine-php

## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

## Define the latest version
latest = 7.4
alpine = 3.10

##
.DEFAULT_GOAL := help
.PHONY: *


help:
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build all images for a specific version of alpine-php ( usage : make build v="7.4" )
	@$(eval version := $(or $(v),$(latest)))
	@$(MAKE) build-base v=$(version)
	@$(MAKE) build-base-dev v=$(version)
	@$(MAKE) build-fpm v=$(version)
	@$(MAKE) build-fpm-dev v=$(version)

build-base: ## Build base images for a specific version of alpine-php ( usage : make build-base v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.template > Dockerfile-base-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-base-$(version) \
		--tag $(DOCKER_IMAGE):$(version) \
		$(DIR)/Dockerfiles

build-base-dev: ## Build base-dev images for a specific version of alpine-php ( usage : make build-base-dev v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@$(MAKE) build-base v=$(version)
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.base.dev.template > Dockerfile-base-dev-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-base-dev-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-dev \
		$(DIR)/Dockerfiles

build-fpm: ## Build fpm images for a specific version of alpine-php ( usage : make build-fpm v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@$(MAKE) build-base v=$(version)
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.fpm.template > Dockerfile-fpm-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-fpm \
		$(DIR)/Dockerfiles

build-fpm-dev: ## Build fpm-dev images for a specific version of alpine-php ( usage : make build-fpm v="7.4" )
	$(eval version := $(or $(v),$(latest)))
	@$(MAKE) build-fpm v=$(version)
	@docker run --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e ALPINE_VERSION=$(alpine) \
		-e PHP_VERSION=$(version) \
		-v $(DIR)/Dockerfiles:/data \
		dsuite/alpine-data \
		bash -c "templater Dockerfile.fpm.dev.template > Dockerfile-fpm-dev-$(version)"
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-fpm-dev-$(version) \
		--tag $(DOCKER_IMAGE):$(version)-fpm-dev \
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
	@$(MAKE) build-base v=$(version)
	@docker push $(DOCKER_IMAGE):$(version)
	@$(MAKE) build-base-dev v=$(version)
	@docker push $(DOCKER_IMAGE):$(version)-dev
	@$(MAKE) build-fpm v=$(version)
	@docker push $(DOCKER_IMAGE):$(version)-fpm
	@$(MAKE) build-fpm-dev v=$(version)
	@docker push $(DOCKER_IMAGE):$(version)-fpm-dev

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
 		-v $(DIR):/data \
		$(DOCKER_IMAGE):$(version)-fpm-dev \
		bash
