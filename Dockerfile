# syntax=docker/dockerfile:experimental

FROM golang:1.13.4-buster

RUN apt-get update

# gettext for `envsubst` command
RUN apt-get install -y nginx gettext

RUN mkdir -p /go/src/github.com/ava-labs

WORKDIR $GOPATH/src/github.com/ava-labs/
COPY . gecko

WORKDIR $GOPATH/src/github.com/ava-labs/gecko

#RUN ./scripts/build.sh

CMD ["/bin/bash", "entrypoint.sh"]
