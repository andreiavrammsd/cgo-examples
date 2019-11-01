FROM ubuntu:18.04

ARG GO=1.13.4

RUN apt update && apt upgrade -y
RUN apt install -y wget make gcc

WORKDIR /tmp
RUN wget https://dl.google.com/go/go${GO}.linux-amd64.tar.gz
RUN tar -xvf go${GO}.linux-amd64.tar.gz
RUN mv go /usr/local

RUN echo export GOROOT=/usr/local/go >> ~/.bashrc
RUN echo export GOPATH=\$HOME/go >> ~/.bashrc
RUN echo export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH >> ~/.bashrc

WORKDIR /src
