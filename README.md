# docker-static-nmap
Alpine Linux Docker container to statically compile Nmap. You can 

## Compile from your own directory
Uses the current directory and drops into interactive bash shell. Your current directory should contain your nmap source code.
```
docker run -it --platform linux/amd64 --entrypoint /bin/bash -v "$(pwd)":/nmap 0xbad53c/static-compile-nmap:latest
```

Next, configure and compile:
```
cd /nmap && ./configure \
    --without-zenmap \
    --without-nping \
    --without-ncat \
    --disable-shared \
    CFLAGS="-static" \
    CXXFLAGS="-static" \
    LDFLAGS="-static" && \
    make && \
    make install
```

## Build latest nmap statically from GitHub
```
docker buildx build --platform linux/amd64 -t 0xbad53c/static-nmap:latest .
```

If you prefer to use the prebuilt image:
```
docker run -it --platform linux/amd64 --entrypoint /bin/bash 0xbad53c/static-nmap:latest
```

You can copy out the nmap binary via:
```
docker cp <containerid>:/nmap/nmap .
```

## Alt: Barebones Docker container to build your own
Useful if e.g. you have your own CI/CD to build nmap statically
```
docker buildx build --platform linux/amd64 -t 0xbad53c/static-compile-nmap:latest -f compile.Dockerfile .
```

In your CI/CD, ensure to include the correct configure command to build static Nmap
```
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
```

