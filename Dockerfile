FROM ubuntu:14.04
MAINTAINER WeiLiang Qian <gliese.q@gmail.com>
LABEL Description="Base image for geographic raster data authorization."

ENV DEBIAN_FRONTEND noninteractive
ENV WORK_DIR /tmp/Droid/
ENV SOURCE_DIR /tmp/Vanilla
ENV TARGET_DIR /tmp/Stage 


# Update source list in China
# RUN cp /etc/apt/sources.list /etc/apt/sources.list.back && \
#    sed -i s/archive.ubuntu.com/mirrors.aliyun.com/ /etc/apt/sources.list
# RUN cat /etc/apt/sources.list
 

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gdal-bin \
    make \
    python-gdal \
    python-pip  \
    postgresql-client \
    postgresql-client-common \
    && pip install awscli

# Check Installation
RUN gdalinfo --version && \
    aws --version && \
    make --version


# initialize directories
RUN mkdir -p $WORK_DIR $SOURCE_DIR $TARGET_DIR

# copy authorization scripts during building child images
ONBUILD COPY Makefile $WORK_DIR

# setup data volumes
VOLUME ["$SOURCE_DIR", "TARGET_DIR"]


ENTRYPOINT ["echo"]
CMD ["Stonemason Droid Base Image\n"]

