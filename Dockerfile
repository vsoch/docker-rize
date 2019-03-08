FROM docker:18.06.3-ce-git

# docker build -t vanessa/docker-r .
# compiled from https://hub.docker.com/r/rocker/r-ver
#               https://hub.docker.com/r/rocker/shiny

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV R_BASE_VERSION 3.5.2

RUN apk add --no-cache bzip2-dev ca-certificates curl-dev pcre-dev perl readline-dev xz-dev zlib-dev autoconf automake gfortran \
    && apk add --no-cache libc-dev g++ make \
    && mkdir /tmp/build_r && cd /tmp/build_r \
    && apk add --no-cache curl \
    && curl -sSLO https://cran.rstudio.com/src/base/R-${R_BASE_VERSION:0:1}/R-${R_BASE_VERSION}.tar.gz \
    && tar xf R-${R_BASE_VERSION}.tar.gz && cd R-${R_BASE_VERSION} \
    && ./configure --build=$CBUILD --host=$CHOST --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --localstatedir=/var --disable-java --without-x \
	&& make -j $(cat /proc/self/status | awk '$1 == "Cpus_allowed_list:" { print $2 }' | tr , '\n' | awk -F'-' '{ if (NF == 2) count += $2 - $1 + 1; else count += 1 } END { print count }') \
	&& make install \
    && rm -rf /tmp/build_r

CMD ["R"]
