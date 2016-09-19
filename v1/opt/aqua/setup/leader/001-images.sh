#!/usr/bin/bash -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../../../../lib/helpers.sh

etcd-set /images/scalock-gateway    "index.docker.io/aquasec/gateway:1.2"
etcd-set /images/scalock-agent      "index.docker.io/aquasec/agent:1.2.1"
etcd-set /images/scalock-server     "index.docker.io/aquasec/server:1.2"


AQUA_INSTALLED=$(docker version | grep -i 1.10.3)

if [[ "$AQUA_INSTALLED" == ""  ]];
then
etcd-set /images/aqua-launcher               \"index.docker.io/behance/aqua-launcher:1.9.1\";
else
etcd-set /images/aqua-launcher               \"index.docker.io/behance/aqua-launcher:latest\";
fi

