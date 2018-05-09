# docker-nginx-make-routines

> Routines to help work with and better understand docker nginx containers

## Makefile
Various routines that 'make' docker a little easier to work with.

```sh

# Start and clean up nginx containers
  $ make build: build the tailored nginx image
  $ make run: run the built container, calls 'build'
  $ make stop: stop container
  $ make clean: clean up the build, calls 'stop'
  $ make delete: delete built image, calls 'clean'

# Routines to work with nginx container
  $ make open: open browser on nginx web page
  $ make ssh: open session with nginx container
  $ make files: meant to copy conf files from base nginx
  $ make vanilla: simple vanilla nginx run

# docker-machine routines
  $ make host: start up docker machine host
  $ make ip: get ip of docker machine host

# misc
  $ make local: run against html files in this project (dynamic)
  $ make conf: same as build but dynamic, for testing configutations

# help
  $ make help
  -----(output)
  build       Build the nginx 'conf' image
  clean       Clean the nginx 'conf' container
  conf        Run the configured 'conf' container
  delete      Delete the nginx 'conf' image, calls stop & clean
  files       Copy nginx default conf & content files from container
  ip          Show docker host IP Address
  local       Run local web content dynamically
  machine     Set enviroment variables to point to active docker machine
  open        Open browser on nginx web page, using docker host IP
  run         Run nginx 'conf' container, calls build
  ssh         SSH into nginx 'conf' container
  stop        Stop nginx 'conf' container
  -----
```

## [License](LICENSE.md)
