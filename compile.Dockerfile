# Base image
FROM alpine:latest

# Install necessary build dependencies
RUN apk add --no-cache \
    build-base \
    libpcap-dev \
    openssl-dev \
    libssh2-dev \
    pcre-dev \
    git \
    python3 \
    linux-headers \
    autoconf \
    automake

# Install cmake for building
RUN apk add cmake

# Set entrypoint to the compiled static nmap binary
ENTRYPOINT ["/bin/sh"]
