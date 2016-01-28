SHELL := /bin/sh
NAME := selenium-chrome-debug
HOST ?= http://localhost

VNC_HOST := $(shell docker-machine active | xargs docker-machine ip)
VNC_PORT := 5900

.PHONY: install serve test clean help

.SILENT: serve help

install: ## Pull any images and install any dependencies.
	docker pull php:7.0-cli
	docker pull selenium/standalone-chrome-debug
	docker run -it --rm \
		-v $$(pwd):/app \
		-v ~/.composer:/root/composer \
		-v ~/.ssh:/root/.ssh:ro \
		composer/composer update --no-interaction --optimize-autoloader --ignore-platform-reqs

serve: ## Start the selenium instance.
	docker rm -f ${NAME} 1> /dev/null || true
	docker run -d -p 4444:4444 -p 5900:${VNC_PORT} --name ${NAME} selenium/standalone-chrome-debug 1> /dev/null
	echo "The VNC address is \033[32m${VNC_HOST}:${VNC_PORT}\033[39m."

test: ## Run all the testsuites.
test:
	docker run --rm -it -v $$(pwd):/opt/graze-web-features -w /opt/graze-web-features -e HOST=${HOST} php:7.0-cli \
	vendor/bin/behat ${ARGS}

clean: ## Clean up!
	docker stop ${NAME}
	docker rm ${NAME}
	rm -rf vendor/

help: ## Show this help message.
	echo "usage: make [target] ..."
	echo ""
	echo "The VNC password is 'secret'."
	echo ""
	echo "targets:"
	fgrep --no-filename "##" $(MAKEFILE_LIST) | fgrep --invert-match $$'\t' | sed -e 's/## / - /'

# If the first argument is "test"...
ifeq (test,$(firstword $(MAKECMDGOALS)))
  # Use the rest as arguments for "test"...
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets.
  $(eval $(ARGS):;@:)
endif
