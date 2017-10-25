FROM ubuntu:xenial

RUN apt-get update && \
    apt-get -qq -y install curl libicu-dev libxml2 libcurl3 libbsd0 && \
    rm -r /var/lib/apt/lists/*

RUN curl -sL https://apt.vapor.sh | bash

RUN apt-get -qq -y install swift vapor && \
    rm -r /var/lib/apt/lists/*

RUN curl -sL check.vapor.sh | bash

ADD . /blockchain
WORKDIR /blockchain

RUN swift build --configuration release

ENTRYPOINT /blockchain/docker-entrypoint.sh