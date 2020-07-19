# syntax=docker/dockerfile:experimental

FROM golang:1.13.4-buster AS builder

WORKDIR /src/github.com/ava-labs/
COPY . gecko
WORKDIR /src/github.com/ava-labs/gecko
RUN ./scripts/build.sh

FROM nginx:latest

COPY --from=builder /src/github.com/ava-labs/gecko/build /build
COPY entrypoint.sh nginx.template ./

CMD ["/bin/bash", "entrypoint.sh"]

