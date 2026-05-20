# syntax=docker/dockerfile:1
FROM public.ecr.aws/docker/library/golang:1.26-bookworm AS builder

ARG VERSION=0.0.1

WORKDIR /src
RUN git clone --branch "v${VERSION}" --depth 1 https://github.com/eleboucher/forgesync.git .

RUN go mod download

RUN CGO_ENABLED=0 go build \
    -ldflags "-s -w -X git.erwanleboucher.dev/eleboucher/forgesync/internal/version.Version=${VERSION}" \
    -trimpath \
    -o /forgesync \
    ./cmd/forgesync

FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /forgesync

COPY --from=builder /forgesync /forgesync/forgesync

EXPOSE 8080

ENTRYPOINT ["/forgesync/forgesync"]
CMD ["run"]
