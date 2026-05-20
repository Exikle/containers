# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM data.forgejo.org/oci/xx AS xx

FROM --platform=$BUILDPLATFORM data.forgejo.org/oci/golang:1.25-alpine3.23 AS build-env

COPY --from=xx / /
ARG TARGETPLATFORM
RUN apk --no-cache add clang lld
RUN xx-apk --no-cache add gcc musl-dev
RUN xx-go --wrap

RUN apk add --no-cache build-base git

ARG VERSION

RUN git clone --branch "v${VERSION}" --depth 1 https://github.com/eleboucher/runner.git /srv

WORKDIR /srv
RUN make clean && make build

FROM data.forgejo.org/oci/alpine:3.23
RUN apk add --no-cache git bash

COPY --from=build-env /srv/forgejo-runner /bin/forgejo-runner

ENV HOME=/data
USER 1000:1000
WORKDIR /data
VOLUME ["/data"]
CMD ["/bin/forgejo-runner"]
