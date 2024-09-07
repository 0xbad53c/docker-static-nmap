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

# Clone Nmap from the official repository
RUN git clone https://github.com/nmap/nmap.git /nmap

# Set working directory
WORKDIR /nmap

# Configure and build a static Nmap binary
RUN ./configure \
    --without-zenmap \
    --without-nping \
    --without-ncat \
    --disable-shared \
    CFLAGS="-static" \
    CXXFLAGS="-static" \
    LDFLAGS="-static" && \
    make && \
    make install

# Run the static Nmap binary as a test
RUN nmap --version

# Set entrypoint to the compiled static nmap binary
ENTRYPOINT ["/usr/local/bin/nmap"]
