SHELL := /bin/sh
NAME := selenium-chrome-debug
HOST ?= http://localhost

VNC_HOST := $(shell docker-machine ip)

SELENIUM_PORT := 4444
SELENIUM_IMAGE := selenium/standalone-chrome-debug:2.53.0

PHP_IMAGE := php:7.0-alpine

.PHONY: install serve test clean help
.SILENT: install serve test clean help

install: ## Pull any images and install any dependencies.
	docker pull ${PHP_IMAGE}
	docker pull ${SELENIUM_IMAGE}
	docker run --rm -it \
		-v $$(pwd):/usr/src/app \
		-v ~/.composer:/home/composer/.composer \
		-v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
		graze/composer update --no-interaction

serve: ## Start the selenium instance.
	docker ps --all --filter name=${NAME} --quiet | xargs docker rm -f 1> /dev/null
	docker run --detach -p 4444:${SELENIUM_PORT} -p 5900 --name ${NAME} ${SELENIUM_IMAGE} 1> /dev/null
	echo "The VNC address is \033[32m${VNC_HOST}:$$(docker port ${NAME} 5900 | sed s/0.0.0.0://)\033[39m."

test: ## Run all the features :rocket:!
	docker run --rm -it -v ${PWD}:/opt/features -w /opt/features -e HOST=${HOST} ${PHP_IMAGE} \
	vendor/bin/behat ${ARGS}

clean: ## Clean up any containers, images, and the vendor folder.
	docker ps --all --filter name=${NAME} --quiet | xargs docker rm -f
	docker rmi ${SELENIUM_IMAGE}
	rm -rf vendor/

.PHONY: help
help: ## Show this help message.
	echo 'usage: make [target] ...'
	echo
	echo 'The VNC password is "secret".'
	echo
	echo 'targets:'
	# The following will dynamically print all targets that have a comment beginning with '##'.
	egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

# If the first argument is "test"...
ifeq (test,$(firstword $(MAKECMDGOALS)))
  # Use the rest as arguments for "test"...
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets.
  $(eval $(ARGS):;@:)
endif
