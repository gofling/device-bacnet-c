
.PHONY: build test clean docker

MICROSERVICES=build/release/device-bacnet-c/device-bacnet-c
.PHONY: $(MICROSERVICES)

DOCKERS=docker_device_bacnet_c
.PHONY: $(DOCKERS)

VERSION=$(shell cat ./VERSION || echo 0.0.0)
GIT_SHA=$(shell git rev-parse HEAD)

build: ${MICROSERVICES}

build/release/device-bacnet-c/device-bacnet-c:
	    scripts/build.sh

test:
	    @echo $(MICROSERVICES)

clean:
	    rm -f $(MICROSERVICES)

docker: $(DOCKERS)

docker_device_bacnet_c:
	    docker build \
	        -f scripts/Dockerfile.alpine-3.11 \
	        --label "git_sha=$(GIT_SHA)" \
	        -t edgexfoundry/docker-device-bacnet-c:${GIT_SHA} \
	        -t edgexfoundry/docker-device-bacnet-c:${VERSION}-dev \
            .
