# docker-nginx-make-routines

> Routines to help work with and better understand docker nginx containers

## Makefile
Various routines that 'make' docker a little easier to work with.

```sh

# Start and clean up nginx containers
  make build: build the tailored nginx image
  make run: run the built container, calls 'build'
  make stop: stop container
  make clean: clean up the build, calls 'stop'
  make delete: delete built image, calls 'clean'

# Routines to work with nginx container
  make open: open browser on nginx web page
  make ssh: open session with nginx container
  make files: meant to copy conf files from base nginx
  make vanilla: simple vanilla nginx run

# docker-machine routines
  make host: start up docker machine host
  make ip: get ip of docker machine host

# misc
  make local: run against html files in this project (dynamic)
  make conf: same as build but dynamic, for testing configutations


```

## [License](LICENSE.md)
