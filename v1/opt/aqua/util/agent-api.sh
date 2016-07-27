#!/usr/bin/bash -x

sudo /opt/scalock/slk auth add core-admin --user core --resource image:*,volume:*,network:*,container:* --role administrator
