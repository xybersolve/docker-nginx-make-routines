.PHONY: machine build run stop clean delete \
	      local vanilla files conf ip open ssh help

file := Dockerfile.conf
image := mynginx
container := mynginx01
hostname := vbx
host := $(shell docker-machine active)
ip := $(shell docker-machine ip $(host))

machine: ## Set enviroment variables to point to active docker machine
	@eval $(shell docker-machine env $(hostname))

ip: ## Show docker host IP Address
	@echo $(ip)

build: ## Build the nginx 'conf' image
	@docker build -t $(image) -f $(file) .

run: build ## Run nginx 'conf' container, calls build
	@docker run --name $(container) -p 8080:80 -d $(image)

stop: ## Stop nginx 'conf' container
	@docker stop $(container)

clean: stop ## Clean the nginx 'conf' container
	@docker rm $(container)

delete: clean ## Delete the nginx 'conf' image, calls stop & clean
	@docker rmi $(image)

local: ## Run local web content dynamically
	@docker run --name $(container) -p 7676:80 \
		-v ~/docker/nginx/html:/usr/share/nginx/html \
		-d nginx

vanilla:
	@docker run --name $(container) \
		-p 8080:80 -d nginx

files: ## Copy nginx default conf & content files from container
	# pull down default config & content files
	@mkdir -p ./files
	@docker cp $(container):/usr/share/nginx/html/ ./files/html/
	@docker cp $(container):/etc/nginx/conf.d/ ./files/conf.d/
	@docker cp $(container):/etc/nginx/nginx.conf ./files/nginx.conf

conf: ## Run the configured 'conf' container
	@docker run --name $(container) \
		-p 8080:80 \
		-v ~/docker/nginx/html:/usr/share/nginx/html \
		-v ~/docker/nginx/conf/default.conf:/etc/nginx/conf.d/default.conf \
		-d \
		nginx

open: ## Open browser on nginx web page, using docker host IP
	@echo "opening web on ip: $(ip)"
	@open http://$(ip):8080

ssh: ## SSH into nginx 'conf' container
	@docker exec -it $(container) /bin/bash

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
