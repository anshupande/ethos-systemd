[Unit]
Description=Make SELinux enforcement permanent
After=docker.service bootstrap.service
Requires=docker.service

[Service]
EnvironmentFile=/etc/environment

User=core
Type=oneshot
RemainAfterExit=false
ExecStart=/usr/bin/sudo bash /home/core/ethos-systemd/v1/util/selinux.sh


[X-Fleet]
Global=false
MachineMetadata=role=worker
MachineMetadata=ip=%i
