FROM alpine:latest

RUN apk add --no-cache curl tini && \
    curl -s https://releases.hashicorp.com/envconsul/0.7.3/envconsul_0.7.3_linux_amd64.tgz | tar -C /usr/local/bin -xz

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
ENTRYPOINT [ "/sbin/tini", "--", "/usr/bin/docker-entrypoint.sh" ]