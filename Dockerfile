FROM ruby:2.5-slim

MAINTAINER katherly@upenn.edu

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential

RUN mkdir /usr/src/app

RUN mkdir /staged

RUN mkdir /todos

RUN mkdir /todos/bulwark

RUN mkdir /todos/openn

ADD . /usr/src/app/

WORKDIR /usr/src/app/

CMD ["bash", "-c", "while [ 1 ]; do sleep 10000; done"]