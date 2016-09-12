#!/usr/bin/bash -x

# Check if Sumologic is installed as optional service, if yes then exit and do not enable selinux

if [[ $(etcdctl get /environment/services |grep sumologic) = *sumologic* ]]; then   exit 0; fi


#To enable SELinux enforcement across reboots, replace the symbolic link /etc/selinux/config with the file it targets, so that the file can be written. You can use the readlink command to dereference the link, as shown in the following one-liner:

sudo cp --remove-destination $(readlink -f /etc/selinux/config) /etc/selinux/config

#replace SELINUX=permissive with SELINUX=enforcing

line="SELINUX=permissive"
rep="SELINUX=enforcing"
sed -i.bak "s/${line}/${rep}/g" /etc/selinux/config
