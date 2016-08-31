ifdef GITHUB_ACCOUNT
	ACCOUNT := $(GITHUB_ACCOUNT)
else
	ACCOUNT := $(USER)
endif
CONTAINER := $(subst docker-,,$(shell basename $(shell dirname $(realpath  $(lastword $(MAKEFILE_LIST))))))
REPOSITORY :=  $(ACCOUNT)/$(CONTAINER)

all: help

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build|release|push APT_PROXY=url"
	@echo "    make test"
	@echo "    make prune"
	@echo

build:
	@docker build \
		--build-arg "APT_PROXY=$(APT_PROXY)" \
		--tag $(REPOSITORY) --rm .

release: build
	@docker build \
		--build-arg "APT_PROXY=$(APT_PROXY)" \
		--tag $(REPOSITORY):$(shell cat VERSION) --rm .

push: release
	@docker push $(REPOSITORY):$(shell cat VERSION)

test:
	@docker run --interactive --tty --rm \
		--name $(CONTAINER) \
		--hostname $(CONTAINER) \
		$(REPOSITORY) \
		python -c "print('Hello World!')"

prune:
	@docker rmi $(REPOSITORY) > /dev/null 2>&1 ||:
	@docker rmi $(REPOSITORY):$(shell cat VERSION) > /dev/null 2>&1 ||:
