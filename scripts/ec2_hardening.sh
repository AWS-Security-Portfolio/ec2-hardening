#!/bin/bash
# EC2 Hardening Script: AWS Security Lab - Week 3
# Author: Sebastian Silva

set -e

# 1. Disable root account login
sudo passwd -l root

# 2. Harden SSH: Disable root login and password authentication
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# 3. Reload SSH service to apply changes
sudo systemctl reload sshd

# 4. Update OS packages
if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [[ "$ID" == "amzn" || "$ID" == "centos" || "$ID" == "rhel" ]]; then
    sudo yum update -y
    sudo yum install -y audit
  elif [[ "$ID" == "ubuntu" || "$ID_LIKE" == "debian" ]]; then
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y auditd
  fi
fi

# 5. Enable and start auditd
sudo systemctl enable auditd
sudo systemctl start auditd

# 6. Show auditd status for verification
sudo systemctl status auditd

echo "Hardening complete. Please verify settings and reboot if necessary."
