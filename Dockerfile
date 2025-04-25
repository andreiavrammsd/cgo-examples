FROM ubuntu:24.04

ARG GO=1.24.2

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget make gcc nano

RUN wget https://dl.google.com/go/go${GO}.linux-amd64.tar.gz \
    && tar -C /usr/local -xvf go${GO}.linux-amd64.tar.gz \
    && rm go${GO}.linux-amd64.tar.gz

RUN echo export PATH=\$PATH:/usr/local/go/bin >> ~/.bash_aliases

WORKDIR /src
