FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV TEST_ROOT_DIR /enterprise-stress-test

RUN apt-get --yes update && apt-get --yes upgrade && \
    apt-get --yes --quiet install wget jq curl

COPY . /enterprise-stress-test

WORKDIR /enterprise-stress-test

RUN /enterprise-stress-test/create-data-files.sh

ENTRYPOINT ["/enterprise-stress-test/entrypoint.sh"]
