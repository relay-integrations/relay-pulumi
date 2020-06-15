FROM pulumi/pulumi:latest
RUN set -eux ; \
    mkdir -p /tmp/ni && \
    cd /tmp/ni && \
    wget https://packages.nebula.puppet.net/sdk/ni/v1/ni-v1-linux-amd64.tar.xz && \
    wget https://packages.nebula.puppet.net/sdk/ni/v1/ni-v1-linux-amd64.tar.xz.sha256 && \
    echo "$( cat ni-v1-linux-amd64.tar.xz.sha256 )  ni-v1-linux-amd64.tar.xz" | sha256sum -c - && \
    tar -xvJf ni-v1-linux-amd64.tar.xz && \
    mv ni-v1*-linux-amd64 /usr/local/bin/ni && \
    cd - && \
    rm -fr /tmp/ni

COPY "./pulumi-entrypoint.sh" "/relay/pulumi-entrypoint.sh"
ENTRYPOINT "/relay/pulumi-entrypoint.sh"

LABEL "org.opencontainers.image.title"="Pulumi for Relay"
LABEL "org.opencontainers.image.description"="This task makes the pulumi and relay runtimes available"
LABEL "com.puppet.nebula.sdk.version"="v1"
