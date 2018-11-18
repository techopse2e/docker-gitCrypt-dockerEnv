FROM gliderlabs/alpine:3.4
ENV GOPATH /opt/go
RUN apk add --update --no-cache \
    bash \
    git \
    go \
    g++ \
    curl \
    make \
    openssh \
    openssl \
    openssl-dev && \
    go get -u github.com/heroku/force && \
    cd $GOPATH/src/github.com/heroku/force \
    go get . && \
    cp $GOPATH/bin/force /usr/local/bin/ && \
    curl -L https://github.com/AGWA/git-crypt/archive/debian/0.6.0-1.tar.gz | tar zxv -C /var/tmp && \
    cd /var/tmp/git-crypt-debian-0.6.0-1 && make && make install PREFIX=/usr/local && rm -rf /var/tmp/* && \
    apk del make openssl-dev && \
    cd / && \
    curl -fSL "https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz" -o docker.tgz && \
    echo "340e0b5a009ba70e1b644136b94d13824db0aeb52e09071410f35a95d94316d9 *docker.tgz" | sha256sum -c - && \
    tar -xzvf docker.tgz && \
    mv docker/* /usr/local/bin/ && \
    rmdir docker && \
    rm docker.tgz && \
    chmod +x /usr/local/bin/docker
