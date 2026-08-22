# Specify the shell environment for make
SHELL := /bin/bash

# Default target
all: docker-build

# CAPEv2 is a git submodule (installer/ is COPYed into the image by the
# Dockerfile); a plain `git clone` leaves it empty, breaking the build with
# "CAPEv2/installer not found". Make sure it's checked out before building.
submodules:
	@echo "Ensuring CAPEv2 submodule is checked out..."
	@git submodule update --init --recursive

# Build Docker image
docker-build: submodules
	@echo "Building Docker image..."
	@docker build -t cape:kvm .

# Declare phony targets
.PHONY: all docker-build submodules
