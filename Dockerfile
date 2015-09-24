FROM ubuntu:14.04
MAINTAINER WeiLiang Qian <gliese.q@gmail.com>
LABEL Description="Base image for geographic raster data authorization."

ENV DEBIAN_FRONTEND noninteractive

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


ENTRYPOINT ["echo"]
CMD ["Stonemason Droid Base Image\n"]
