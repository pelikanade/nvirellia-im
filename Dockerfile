FROM golang:1.26-alpine AS builder

WORKDIR /src

COPY go.mod ./
COPY . .

RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/nvirellia-im ./cmd/nvirellia-im

FROM alpine:3.21

RUN apk add --no-cache ca-certificates \
    && adduser -D -H -u 10001 -s /sbin/nologin nvirellia

COPY --from=builder /out/nvirellia-im /usr/local/bin/nvirellia-im

USER nvirellia

ENV LISTEN_ADDR=:8080
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1

ENTRYPOINT ["/usr/local/bin/nvirellia-im"]
