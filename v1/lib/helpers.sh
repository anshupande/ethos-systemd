#!/usr/bin/bash -x

# Source the etcd
if [ -f /etc/profile.d/etcdctl.sh ]; then
  source /etc/profile.d/etcdctl.sh;
fi

# Handle retrying of all etcd sets and gets
function etcd-set() {
    etcdctl -u $ETCD_USER:$ETCD_PASSWORD set "$@"
    while [ $? != 0 ]; do sleep 1; etcdctl -u $ETCD_USER:$ETCD_PASSWORD set $@; done
}

function etcd-get() {
    etcdctl -u $ETCD_USER:$ETCD_PASSWORD get "$@"
    # "0" and "4" responses were successful, "4" means the key intentionally doesn't exist
    while [[ $? != 0 && $? != 4 ]]; do sleep 1; etcdctl -u $ETCD_USER:$ETCD_PASSWORD get $@; done
}

# Handle retrying of all fleet submits and starts
function submit-fleet-unit() {
    sudo fleetctl submit "$@"
    while [ $? != 0 ]; do sleep 1; sudo fleetctl submit $@; done
}

function start-fleet-unit() {
    sudo fleetctl start "$@"
    while [ $? != 0 ]; do sleep 1; sudo fleetctl start $@; done
}
