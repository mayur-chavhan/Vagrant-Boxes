#!/bin/bash

echo 'Github: https://github.com/mayur-chavhan'
echo 'Facebook: https://www.facebook.com/techwhale.in'
echo ''

# Enable ssh password authentication
echo "Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "Set root password"
echo -e "admin\nadmin" | passwd root >/dev/null 2>&1

# Set local user account
echo "Set up local user account"

# adding user mayur but you can change to something else.
useradd -m -s /bin/bash mayur

#setting up password to admin, recommend if you use for production change to something more challenging.
echo -e "admin\nadmin" | passwd mayur >/dev/null 2>&1

# replace mayur to your desire username
echo "mayur ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Update bashrc file
echo "export TERM=xterm" >> /etc/bashrc

echo -e "Public LAN IP : $(ip address show eth1 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//')" | tee /vagrant/public_ip.txt