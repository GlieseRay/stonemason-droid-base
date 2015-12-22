FROM        debian:jessie
MAINTAINER  WeiLiang Qian <gliese.q@gmail.com>
LABEL       Description="Base image for geo data authorization."

ENV         DEBIAN_FRONTEND noninteractive

RUN         set -x \
            && apt-get update \
            && apt-get install -y --no-install-recommends \
                locales \
                curl \
                make \
                gdal-bin \
                python-gdal \
                python-pip  \
                postgresql-client \
                postgresql-client-common \
                postgis \
            && pip install awscli

RUN         set -x \
            && dpkg-reconfigure locales \
            && /usr/sbin/update-locale LANG=C.UTF-8 \
            && echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
            && locale-gen

ENV         LANG=en_US.UTF-8 \
            LANGUAGE=en_US:en \
            LC_ALL=en_US.UTF-8

WORKDIR     /root

RUN         curl -sSL http://imposm.org/static/rel/imposm3-0.1dev-20150515-593f252-linux-x86-64.tar.gz | tar xfz -

ENV         PATH=/root/imposm3-0.1dev-20150515-593f252-linux-x86-64:$PATH

RUN         set -x \
            && python -c 'import gdal; print("GDAL Version:", gdal.VersionInfo())' \
            && imposm3 version \
            && psql --version
