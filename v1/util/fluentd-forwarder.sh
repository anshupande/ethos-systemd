#!/usr/bin/bash

if [[ -f /etc/profile.d/etcdctl.sh ]];
  then source /etc/profile.d/etcdctl.sh;
fi

source /etc/environment

IMAGE=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /images/fluentd)
FLUENTD_FORWARDER_PORT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-forwarder-port)
FLUENTD_MONITOR_PORT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-monitor-port)

/usr/bin/docker run \
  --name fluentd-forwarder \
  -p $FLUENTD_FORWARDER_PORT:5170 \
  -p $FLUENTD_MONITOR_PORT:24220 \
  -e FLUENTD_CONF=fluentd-universal.conf \
  -e FLUENTD_ETHOSPLUGIN_CACHE_SIZE=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-ethosplugin-cache-size) \
  -e FLUENTD_ETHOSPLUGIN_CACHE_TTL=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-ethosplugin-cache-ttl) \
  -e FLUENTD_ETHOSPLUGIN_GET_TAG_FLAG=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-ethosplugin-get-tag-flag) \
  -e FLUENTD_ETHOSPLUGIN_CONTAINER_TAG=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-ethosplugin-container-tag) \
  -e FLUENTD_ETHOSPLUGIN_LOGTYPE_RULE="$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-ethosplugin-logtype-rule)" \
  -e FLUENTD_HTTPEXT_BUFFER_TYPE=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-buffer-type) \
  -e FLUENTD_HTTPEXT_BUFFER_QUEUE_LIMIT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-buffer-queue-limit) \
  -e FLUENTD_HTTPEXT_BUFFER_CHUNK_LIMIT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-buffer-chunk-limit) \
  -e FLUENTD_HTTPEXT_FLUSH_INTERVAL=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-flush-interval) \
  -e FLUENTD_HTTPEXT_FLUSH_AT_SHUTDOWN=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-flush-at-shutdown) \
  -e FLUENTD_HTTPEXT_RETRY_WAIT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-retry-wait) \
  -e FLUENTD_HTTPEXT_MAX_RETRY_WAIT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-max-retry-wait) \
  -e FLUENTD_HTTPEXT_RETRY_LIMIT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-retry-limit) \
  -e FLUENTD_HTTPEXT_DISABLE_RETRY_LIMIT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-disable-retry-limit) \
  -e FLUENTD_HTTPEXT_SPLUNK_URL=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-splunk-url) \
  -e FLUENTD_HTTPEXT_HTTP_METHOD=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-http-method) \
  -e FLUENTD_HTTPEXT_SERIALIZER=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-serializer) \
  -e FLUENTD_HTTPEXT_USE_SSL=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-use-ssl) \
  -e FLUENTD_HTTPEXT_OPEN_TIMEOUT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-open-timeout) \
  -e FLUENTD_HTTPEXT_READ_TIMEOUT=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-read-timeout) \
  -e FLUENTD_HTTPEXT_RATE_LIMIT_MSEC=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-rate-limit-msec) \
  -e FLUENTD_HTTPEXT_RAISE_ON_ERROR=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-raise-on-error) \
  -e FLUENTD_HTTPEXT_RAISE_ON_HTTP_FAILURE=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-raise-on-http-failure) \
  -e FLUENTD_HTTPEXT_IGNORE_HTTP_STATUS_CODE=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-ignore-http-status-code) \
  -e FLUENTD_HTTPEXT_AUTHENTICATION=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-authentication) \
  -e FLUENTD_HTTPEXT_USERNAME=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-username) \
  -e FLUENTD_HTTPEXT_PASSWORD=$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-password) \
  -e FLUENTD_HTTPEXT_SPLUNK_HEC_TOKEN="$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-splunk-hec-token)" \
  -e FLUENTD_HTTPEXT_SPLUNK_HEC_LVC_TOKEN="$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-splunk-hec-lvc-token)" \
  -e FLUENTD_HTTPEXT_SPLUNK_HEC_HVC_TOKEN="$(/home/core/ethos-systemd/v1/lib/etcdauth.sh get /logging/config/fluentd-httpext-splunk-hec-hvc-token)" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  $IMAGE
