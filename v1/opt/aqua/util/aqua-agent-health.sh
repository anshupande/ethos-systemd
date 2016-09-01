#!/usr/bin/bash -x

until sudo docker stop aquasec-agent- 2>&1| grep -m 1 "Unauthorized"; do : ; done
