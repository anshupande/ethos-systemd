#!/usr/bin/bash -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source /etc/environment
source $DIR/../../lib/helpers.sh

echo "-------Leader node, beginning writing all default values to etcd-------"

######################
#     IMAGES
######################

# TODO: this overloads the machine

etcd-authset /bootstrap.service/images-base-bootstrapped true

etcd-authset /images/secrets-downloader     "index.docker.io/behance/docker-aws-secrets-downloader:latest"

etcd-authset /bootstrap.service/images-control-bootstrapped true

etcd-authset /images/chronos                "index.docker.io/mesosphere/chronos:chronos-2.4.0-0.1.20150828104228.ubuntu1404-mesos-0.27.0-0.2.190.ubuntu1404"
etcd-authset /images/flight-director        "index.docker.io/behance/flight-director:latest"
etcd-authset /images/marathon               "index.docker.io/mesosphere/marathon:v0.15.1"
etcd-authset /images/mesos-master           "index.docker.io/mesosphere/mesos-master:0.27.0-0.2.190.ubuntu1404"
etcd-authset /images/zk-exhibitor           "index.docker.io/behance/docker-zk-exhibitor:latest"
etcd-authset /images/cfn-signal             "index.docker.io/behance/docker-cfn-bootstrap:latest"
etcd-authset /images/jenkins                "index.docker.io/jenkins:1.651.1"

etcd-authset /bootstrap.service/images-proxy-bootstrapped true

etcd-authset /images/capcom                 "index.docker.io/behance/capcom:latest"
etcd-authset /images/capcom2                "index.docker.io/behance/capcom:latest"
etcd-authset /images/proxy                  "index.docker.io/nginx:1.9.5"
etcd-authset /images/proxy-setup            "index.docker.io/behance/mesos-proxy-setup:latest"
etcd-authset /images/control-proxy          "index.docker.io/behance/apigateway:v0.0.1"

etcd-authset /bootstrap.service/images-worker-bootstrapped true

etcd-authset /images/mesos-slave            "index.docker.io/mesosphere/mesos-slave:0.27.0-0.2.190.ubuntu1404"


######################
#      CAPCOM
######################

etcd-authset /bootstrap.service/capcom              true
etcd-authset /capcom/config/applications            '[]'
etcd-authset /capcom/config/host                    127.0.0.1
etcd-authset /capcom/config/db-path                 ./capcom.db
etcd-authset /capcom/config/kv-store-server-address http://$CAPCOM_KV_ENDPOINT
etcd-authset /capcom/config/kv-ttl                  10
etcd-authset /capcom/config/log-level               "$CAPCOM_LOG_LEVEL"
etcd-authset /capcom/config/log-location            "$CAPCOM_LOG_LOCATION"
etcd-authset /capcom/config/port                    2002
etcd-authset /capcom/config/proxy                   nginx
etcd-authset /capcom/config/proxy-config-file       /etc/nginx/nginx.conf
etcd-authset /capcom/config/proxy-enabled           true
etcd-authset /capcom/config/proxy-restart-script    /restart_nginx_docker.sh
etcd-authset /capcom/config/proxy-timeout           60000
etcd-authset /capcom/config/proxy-docker-command    "nginx -g 'daemon off;'"
etcd-authset /capcom/config/ssl-cert-location       ""


######################
#  FLIGHT DIRECTOR
######################

etcd-authset /bootstrap.service/flight-director true
etcd-authset /flight-director/config/api-server-port 2001
etcd-authset /flight-director/config/chronos-master "$FLIGHT_DIRECTOR_CHRONOS_ENDPOINT"
etcd-authset /flight-director/config/db-name "$FLIGHT_DIRECTOR_DB_NAME"
etcd-authset /flight-director/config/db-engine mysql
etcd-authset /flight-director/config/db-path "$FLIGHT_DIRECTOR_DB_PATH"
etcd-authset /flight-director/config/db-username "$FLIGHT_DIRECTOR_DB_USERNAME"
etcd-authset /flight-director/config/dockercfg-location file:///root/.dockercfg
etcd-authset /flight-director/config/debug false
etcd-authset /flight-director/config/event-interface ''
etcd-authset /flight-director/config/event-port 2001
etcd-authset /flight-director/config/fixtures "$FLIGHT_DIRECTOR_FIXTURES"
etcd-authset /flight-director/config/kv-server http://localhost:2379
etcd-authset /flight-director/config/log-level "$FLIGHT_DIRECTOR_LOG_LEVEL"
etcd-authset /flight-director/config/log-location "$FLIGHT_DIRECTOR_LOG_LOCATION"
etcd-authset /flight-director/config/log-marathon-api-calls false
etcd-authset /flight-director/config/marathon-master "$FLIGHT_DIRECTOR_MARATHON_ENDPOINT"
etcd-authset /flight-director/config/mesos-master "$FLIGHT_DIRECTOR_MESOS_ENDPOINT"
etcd-authset /flight-director/config/marathon-master-protocol http
etcd-authset /flight-director/config/allow-marathon-unverified-tls false
etcd-authset /flight-director/config/mesos-master-protocol http
etcd-authset /flight-director/config/authorizer-type airlock
etcd-authset /flight-director/config/iam-role-label com.swipely.iam-docker.iam-profile


######################
#     ZOOKEEPER
######################

etcd-authset /bootstrap.service/zookeeper true

etcd-authset /zookeeper/config/exhibitor/s3-prefix  "zk"
etcd-authset /zookeeper/config/exhibitor/s3-bucket  $EXHIBITOR_S3BUCKET
etcd-authset /zookeeper/config/ensemble-size        $CONTROL_CLUSTER_SIZE
etcd-authset /zookeeper/config/endpoint             $ZOOKEEPER_ENDPOINT
etcd-authset /zookeeper/config/username             "zk"
etcd-authset /zookeeper/config/password             "password"


######################
#        MESOS
######################

etcd-authset /mesos/config/username ethos


######################
#      SERVICES
######################

etcd-authset /environment/services "sumologic datadog"

echo "-------Leader node, done writing all default values to etcd-------"
