FROM rocker/shiny:3.5.2

# docker build -t vanessa/docker-r .
# compiled from https://hub.docker.com/r/rocker/r-ver
#               https://hub.docker.com/r/rocker/shiny

ENV DEBIAN_FRONTEND noninteractive

COPY --from=docker:18.09.3 /usr/local/bin/docker /usr/local/bin/
RUN apt update && apt install -y openssl libssl-dev git && \
     Rscript -e "install.packages('remotes', repos = 'http://cran.us.r-project.org')" && \
     Rscript -e "remotes::install_github('cole-brokamp/rize')" && \
     docker --version

CMD ["Rscript", "-e", "rize::shiny_dockerize()"]
