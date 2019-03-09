# Docker Rize

This is a container that uses `rocker/shiny` as a base, and adds the
 [docker](https://hub.docker.com/_/docker) client on top of it, and then
we can use those two as a base image in CI to build rize application images.

```bash
$ docker build -t vanessa/docker-rize .
```
