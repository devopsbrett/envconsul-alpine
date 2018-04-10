#!/bin/sh

disable_envconsul() {
    exec "$@"
}

ENVCONSUL_OPTS="-sanitize"
USE_ENVCONSUL="no"

if [ -r /etc/envconsul.hcl ]; then
    ENVCONSUL_OPTS="$ENVCONSUL_OPTS -config=/etc/envconsul.hcl"
    USE_ENVCONSUL="yes"
fi

if [ -n "$CONSUL_ADDR" ]; then
    ENVCONSUL_OPTS="$ENVCONSUL_OPTS -consul-addr=$CONSUL_ADDR"
    USE_ENVCONSUL="yes"
fi

if [ "$USE_ENVCONSUL" == "no" ]; then
    disable_envconsul $@
fi

if [ -n "$CONSUL_TOKEN" ]; then
    ENVCONSUL_OPTS="$ENVCONSUL_OPTS -consul-token=$CONSUL_TOKEN"
fi

if [ -z "$NO_UPCASE" ]; then
    ENVCONSUL_OPTS="$ENVCONSUL_OPTS -upcase"
fi

if [ -n "$CONSUL_KVPREFIX" ]; then
    ENVCONSUL_OPTS="$ENVCONSUL_OPTS -prefix=$CONSUL_KVPREFIX"
fi

exec envconsul $ENVCONSUL_OPTS $@