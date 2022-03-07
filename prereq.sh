#!/usr/bin/env bash
set -x

#
systemctl stop autofs.service puppet.service
systemctl disable autofs.service puppet.service

if id "teuthology" &>/dev/null; then
    echo 'user found'
else
    echo 'user not found... creating...'
    sudo adduser teuthology --gecos "Teuthology,1,2,3" --disabled-password
fi

echo "teuthology:seagate1" | sudo chpasswd

if id "teuthworker" &>/dev/null; then
    echo 'user found'
else
    echo 'user not found... creating...'
    sudo adduser teuthworker --gecos "Teuthworker,4,5,6" --disabled-password
fi
#
echo "teuthworker:seagate1" | sudo chpasswd

echo "ubuntu:seagate1" | sudo chpasswd

# Run perl command for fstab attrib
perl -pe 'if (m{^([^#]\\S*\\s+/\\s+\\S+\\s+)(\\S+)(\\s+.*)$}) { $_="$1$2,user_xattr$3\n" unless $2=~m{(^|,)user_xattr(,|$)}; }' -i.bak /etc/fstab
# Install ntp on Ubuntu so that we can sync manually. This is needed for apt-get repo getting 'not valid yet' error
sudo apt install ntpdate -y

# Ntpd permissions issue: # vim /etc/apparmor.d/usr.sbin.ntpd --> Will need sed/awk etc.
# change rawstats* to raw*
# If the node has rebooted need to run the
systemctl reload apparmor
