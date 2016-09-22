#!/usr/bin/bash -x

sudo touch /etc/audit/rules.d/88-audit.rules
sudo chmod 666 /etc/audit/rules.d/88-audit.rules
sudo echo "-w /usr/bin/docker -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /var/lib/docker -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /etc/docker -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /usr/lib64/systemd/system/docker.service -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /usr/lib64/systemd/system/docker.socket -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /etc/default/docker -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /etc/docker/daemon.json -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /usr/bin/docker-containerd -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo echo "-w /usr/bin/docker-runc -k docker" >> /etc/audit/rules.d/88-audit.rules
sudo chmod 644 /etc/audit/rules.d/88-audit.rules
sudo systemctl restart audit-rules.service
