[![Circle CI](https://circleci.com/gh/codeworksio/docker-python.svg?style=shield "CircleCI")](https://circleci.com/gh/codeworksio/docker-python)&nbsp;[![Size](https://images.microbadger.com/badges/image/codeworksio/python.svg)](http://microbadger.com/images/codeworksio/python)&nbsp;[![Version](https://images.microbadger.com/badges/version/codeworksio/python.svg)](http://microbadger.com/images/codeworksio/python)&nbsp;[![Commit](https://images.microbadger.com/badges/commit/codeworksio/python.svg)](http://microbadger.com/images/codeworksio/python)&nbsp;[![Docker Hub](https://img.shields.io/docker/pulls/codeworksio/python.svg)](https://hub.docker.com/r/codeworksio/python/)

Docker Python
=============

Customised Python base image.

Installation
------------

Builds of the image are available on [Docker Hub](https://hub.docker.com/r/codeworksio/python/).

    docker pull codeworksio/python

Alternatively you can build the image yourself.

    docker build --tag codeworksio/python \
        github.com/codeworksio/docker-python

Testing
-------

    make build test
