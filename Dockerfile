# First stage: build the executable.
FROM docker.io/library/golang:1.25-alpine as builder
WORKDIR /go/src/github.com/liip/clamav-prometheus-exporter/
COPY . .

ARG VERSION=latest

RUN apk add --no-cache make
RUN make build VERSION=$VERSION

# Final stage: the running container.
# Use a minimal image for running the application
FROM docker.io/library/alpine:3.22 AS final

# Install necessary certificates
RUN apk add --no-cache ca-certificates

# Set the working directory for the runtime
WORKDIR /bin/

# Import the compiled executable from the first stage.
COPY --from=builder /go/src/github.com/liip/clamav-prometheus-exporter/clamav-prometheus-exporter .

RUN addgroup prometheus
RUN adduser -S -u 1000 prometheus \
  && chown -R prometheus:prometheus /bin

USER 1000
# Default port for metrics exporters
EXPOSE 9810
ENTRYPOINT [ "/bin/clamav-prometheus-exporter" ]
