FROM ubuntu:14.04
MAINTAINER WeiLiang Qian <gliese.q@gmail.com>
LABEL Description="Base image for geo data authorization."

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8


RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    gdal-bin \
    make \
    python-gdal \
    python-pip  \
    postgresql-client \
    postgresql-client-common \
    postgis \
    && pip install awscli

WORKDIR /root

RUN set -x \
    && wget http://imposm.org/static/rel/imposm3-0.1dev-20150515-593f252-linux-x86-64.tar.gz \
    && tar xzf imposm3-0.1dev-20150515-593f252-linux-x86-64.tar.gz

ENV PATH=/root/imposm3-0.1dev-20150515-593f252-linux-x86-64:$PATH


RUN set -x \
    && python -c 'import gdal; print("GDAL Version:", gdal.VersionInfo())' \
    && imposm3 version \
    && psql --version

