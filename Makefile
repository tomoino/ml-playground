.DEFAULT_GOAL := help

# const
USER_NAME := $(shell whoami)
IMAGE_NAME := mlp_$(USER_NAME)
CONTAINER_NAME := mlp_$(USER_NAME)
JUPYTER_PORT := 8888

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)
export CURRENT_UID
export CURRENT_GID

## build docker image
.PHONY: build
build:
	docker build -t ${IMAGE_NAME} --force-rm=true --no-cache -f docker/Dockerfile .

## run docker container
.PHONY: up
up:
	docker run --gpus all --rm --name ${CONTAINER_NAME} --shm-size=8g -p ${JUPYTER_PORT}:8888 --env USER_ID=${CURRENT_UID} --env GROUP_ID=${CURRENT_GID} -v ${PWD}/src:/workspace -w /workspace -dit ${IMAGE_NAME}

## run jupyter notebook in container
.PHONY: jlab
jlab:
	docker exec -w /workspace -it ${IMAGE_NAME} jupyter-lab --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password='' --notebook-dir=/workspace

## run bash in container
.PHONY: exec
exec:
	docker exec -w /workspace -it ${CONTAINER_NAME} bash

## down the container
.PHONY: down
down:
	docker stop ${CONTAINER_NAME}

## help
.PHONY: help
help:
	@printf "\nusage : make <commands> \n\nthe following commands are available : \n\n"
	@cat $(MAKEFILE_LIST) | awk '1;/help:/{exit}' | awk '!/^.PHONY:.*/' | awk '/##/ { print; getline; print; }' | awk '{ getline x; print x; }1' | awk '{ key=$$0; getline; printf "\033[36m%-30s\033[0m %s\n", key, $$0;}' | sed -e 's/##//' | sed -e 's/://'
	@printf "\n"