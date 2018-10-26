#!/bin/bash -eux

printf "STEP: Remove unused packages\n"
# Uninstall Puppet and remove PPA.
apt -y remove --purge puppet
apt -y remove --purge ppp pppconfig pppoeconf cpp gcc g++ libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6 linux-source
apt -y remove --purge '.*-dev$'
apt -y autoremove

# Remove APT cache
printf "STEP: Remove APT cache\n"
apt-get clean -y
apt-get autoclean -y
 
# Remove APT files
printf "STEP: Zero free space to aid VM compression\n"
find /var/lib/apt -type f | xargs rm -f
 
# Remove documentation files
printf "STEP: Remove documentation files\n"
find /var/lib/doc -type f | xargs rm -f
 
# vagrant: Remove Virtualbox specific files
printf "STEP: vagrant: Remove Virtualbox specific files\n"
rm -rf /usr/src/vboxguest* /usr/src/virtualbox-ose-guest*
 
# Remove Linux headers
printf "STEP: Remove Linux headers\n"
rm -rf /usr/src/linux-headers*
 
# Remove bash history
printf "STEP: Remove bash history\n"
unset HISTFILE
rm -f /root/.bash_history

# Delete unneeded files.
rm -f /home/vagrant/*.sh

# vagrant: Remove bash history
printf "STEP: vagrant: Remove bash history\n"
rm -f /home/vagrant/.bash_history
 
# Cleanup log files
printf "STEP: Cleanup log files\n"
find /var/log -type f | while read f; do echo -ne '' > $f; done;
 
 # Zero free space to aid VM compression
printf "STEP: Zero free space to aid VM compression\n"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Whiteout root
printf "STEP: Whiteout root\n"
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;
 
# Whiteout /boot
printf "STEP: Whiteout /boot\n"
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;
 
# Whiteout swap 
printf "STEP: Whiteout swap\n"
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
