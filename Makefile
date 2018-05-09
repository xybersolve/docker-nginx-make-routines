.PHONY: machine build run stop clean delete local vanilla files conf ip open ssh

file := Dockerfile.conf
image := mynginx
container := mynginx01
host := $(shell docker-machine active)
ip := $(shell docker-machine ip $(host))

machine:
	@eval $(shell docker-machine env $(host))

ip:
	@echo $(ip)

build:
	@docker build -t $(image) -f $(file) .

run: build
	@docker run --name $(container) -p 8080:80 -d $(image)

stop:
	@docker stop $(container)

clean: stop
	@docker rm $(container)

delete: clean
	@docker rmi $(image)

local:
	@docker run --name $(container) -p 7676:80 \
		-v ~/docker/nginx/html:/usr/share/nginx/html \
		-d nginx

vanilla:
	@docker run --name $(container) \
		-p 8080:80 -d nginx

files:
	# pull down default config & content files
	@mkdir -p ./files
	@docker cp $(container):/usr/share/nginx/html/ ./files/html/
	@docker cp $(container):/etc/nginx/conf.d/ ./files/conf.d/
	@docker cp $(container):/etc/nginx/nginx.conf ./files/nginx.conf

conf:
	@docker run --name $(container) \
		-p 8080:80 \
		-v ~/docker/nginx/html:/usr/share/nginx/html \
		-v ~/docker/nginx/conf/default.conf:/etc/nginx/conf.d/default.conf \
		-d \
		nginx

open:
	#open http://$(shell docker-machine active)
	@echo "opening web on ip: $(ip)"
	@open http://$(ip):8080

ssh:
	@docker exec -it $(container) /bin/bash
