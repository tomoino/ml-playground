# container 用
.DEFAULT_GOAL := help

## create a new project
.PHONY: project
project:
	mkdir -p ${PJT}
	ln -s ./pyproject.toml ${PJT}/pyproject.toml

## help
.PHONY: help
help:
	@printf "\nusage : make <commands> \n\nthe following commands are available : \n\n"
	@cat $(MAKEFILE_LIST) | awk '1;/help:/{exit}' | awk '!/^.PHONY:.*/' | awk '/##/ { print; getline; print; }' | awk '{ getline x; print x; }1' | awk '{ key=$$0; getline; printf "\033[36m%-30s\033[0m %s\n", key, $$0;}' | sed -e 's/##//' | sed -e 's/://'
	@printf "\n"