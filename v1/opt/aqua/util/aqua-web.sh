#!/usr/bin/bash -x

source /etc/environment


IMAGE=$(etcdctl get /images/scalock-server)
SCALOCK_ADMIN_PASSWORD=$(etcdctl get /aqua/config/password)
DB_PASSWORD=$(etcdctl get /environment/RDSPASSWORD)
DB_USERNAME=$(etcdctl get /flight-director/config/db-username)
SCALOCK_DB_NAME=$(etcdctl get /aqua/config/db-name)
SCALOCK_DB_ENDPOINT=$(etcdctl get /aqua/config/db-path)
SCALOCK_GATEWAY_ENDPOINT=$(etcdctl get /aqua/config/gateway-host)
SCALOCK_AUDIT_DB_NAME=$(etcdctl get /aqua/config/db-audit-name)
SCALOCK_TOKEN=$(etcdctl get /aqua/config/aqua-token)

/usr/bin/sh -c "sudo docker run -p 8083:8080 \
   --name aqua-web --user=root \
   -e SCALOCK_DBUSER=$DB_USERNAME  \
   -e SCALOCK_DBPASSWORD=$DB_PASSWORD \
   -e SCALOCK_DBNAME=$SCALOCK_DB_NAME \
   -e SCALOCK_DBHOST=$SCALOCK_DB_ENDPOINT \
   -e SCALOCK_AUDIT_DBUSER=$DB_USERNAME \
   -e SCALOCK_AUDIT_DBPASSWORD=$DB_PASSWORD \
   -e SCALOCK_AUDIT_DBNAME=$SCALOCK_AUDIT_DB_NAME \
   -e SCALOCK_AUDIT_DBHOST=$SCALOCK_DB_ENDPOINT \
   -e SCALOCK_KERNEL_MODE_ENABLED=false \
   -e ADMIN_PASSWORD=$SCALOCK_ADMIN_PASSWORD \
   -e BATCH_INSTALL_TOKEN=\"$SCALOCK_TOKEN\" \
   -e BATCH_INSTALL_NAME=Local-Agents \
   -e BATCH_INSTALL_GATEWAY=$AQUA_INTERNAL_ELB \
   -e BATCH_INSTALL_ENFORCE_MODE=y \
   -v /var/run/docker.sock:/var/run/docker.sock \
   $IMAGE"

# Wait for web ui to be active
WEB_ACTIVE=$(curl http://localhost:8083/api|grep aqua)

while [[ -z $WEB_ACTIVE ]]; do
  echo "Waiting for web UI to become active"
  WEB_ACTIVE=$(curl http://localhost:8083/api|grep aqua)
  sleep 5;
done

curl -H "Content-Type: application/json" -u administrator:`etcdctl get /aqua/config/password` -X POST -d '{"name":"core-user rule","description": "Core User is Admin of all containers","role":"administrator","resources":{"containers":["*"],"images":["*"],"volumes":["*"],"networks":["*"]},"accessors":{"users":["core"]}}' http://localhost:8083/api/v1/adminrules
