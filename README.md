[![CircleCI](https://circleci.com/gh/stefaniuk/docker-python.svg?style=shield "CircleCI")](https://circleci.com/gh/stefaniuk/docker-python) [![Quay](https://quay.io/repository/stefaniuk/python/status "Quay")](https://quay.io/repository/stefaniuk/python)

Docker Python
=============

My customised Python baseimage.

Installation
------------

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/r/stefaniuk/python/).

    docker pull stefaniuk/python:latest

Alternatively you can build the image yourself.

    docker build --tag stefaniuk/python \
        github.com/stefaniuk/docker-python
