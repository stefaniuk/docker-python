TARGETS := $(shell cat $(realpath $(lastword $(MAKEFILE_LIST))) | grep "^[a-z]*:" | awk '{ print $$1; }' | sed 's/://g' | grep -vE 'all|help' | paste -sd "|" -)
NAME := $(subst docker-,,$(shell basename $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))))
IMAGE := codeworksio/$(NAME)

all: help

help:
	echo
	echo "Usage:"
	echo
	echo "    make $(TARGETS) [APT_PROXY|APT_PROXY_SSL=ip:port]"
	echo

build:
	docker build \
		--build-arg APT_PROXY=$(APT_PROXY) \
		--build-arg APT_PROXY_SSL=$(APT_PROXY_SSL) \
		--build-arg IMAGE=$(IMAGE) \
		--build-arg BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg VERSION=$(shell cat VERSION) \
		--build-arg VCS_REF=$(shell git rev-parse --short HEAD) \
		--build-arg VCS_URL=$(shell git config --get remote.origin.url) \
		--tag $(IMAGE):$(shell cat VERSION) \
		--rm .
	docker tag $(IMAGE):$(shell cat VERSION) $(IMAGE):latest
	docker rmi --force $$(docker images | grep "<none>" | awk '{ print $$3 }') 2> /dev/null ||:

start:
	docker run --detach --interactive --tty \
		--name $(NAME) \
		--hostname $(NAME) \
		--env "INIT_DEBUG=true" \
		$(IMAGE) \
		/bin/bash --login

stop:
	docker stop $(NAME) > /dev/null 2>&1 ||:
	docker rm $(NAME) > /dev/null 2>&1 ||:

log:
	docker logs --follow $(NAME)

test:
	docker run --interactive --tty --rm codeworksio/python \
		ps aux | grep 'default.\+ps aux'
	docker run --interactive --tty --rm codeworksio/python \
		python -c "print('Hello World!')"
	docker run --interactive --tty --rm --volume $(shell pwd)/assets/tmp:/tmp codeworksio/python \
		python /tmp/HelloWorld.py

bash:
	docker exec --interactive --tty \
		--user root \
		$(NAME) \
		/bin/bash --login ||:

clean:
	docker rmi --force $(IMAGE):$(shell cat VERSION) > /dev/null 2>&1 ||:
	docker rmi --force $(IMAGE):latest > /dev/null 2>&1 ||:
	docker rmi --force $$(docker images | grep "<none>" | awk '{ print $$3 }') 2> /dev/null ||:

push:
	docker push $(IMAGE):$(shell cat VERSION)
	docker push $(IMAGE):latest
	sleep 10
	curl --request POST "https://hooks.microbadger.com/images/$(IMAGE)/WY5PNBLSYOl5lOIKzjdgs9aH8_M="

.SILENT:
