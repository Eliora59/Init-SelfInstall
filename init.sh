#!/bin/bash
DETECT_DISTRIB="`cat /etc/os-release | grep '^NAME'`"
DEBIAN='NAME="Debian GNU/Linux"'
RHEL='NAME="Red Hat Enterprise Linux"'
ARCH='NAME="Arch Linux"'


if [ "$DETECT_DISTRIB" == "$DEBIAN" ];then
echo "Modification of sources.list for SID"
echo "deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list
echo "deb-src https://deb.debian.org/debian sid main contrib non-free" >> /etc/apt/sources.list

echo "Refresh metadatas of repository"
apt update
echo "Installation of prerequisite"
DEBIAN_FRONTEND=noninteractive apt install -y git ansible

echo "Exécution du playbook d'installation"
/usr/bin/ansible-pull SelfInstall.yml -U https://github.com/Eliora59/SelfInstall.git -vvv

elif [ "$DETECT_DISTRIB" == "$RHEL" ];then
dnf install -y git ansible
/usr/bin/ansible-pull SelfInstall.yml -U https://github.com/Eliora59/SelfInstall.git -vvv

elif [ "$DETECT_DISTRIB" == "$ARCH" ];then
pacman -S git ansible --noconfirm
/usr/bin/ansible-pull SelfInstall.yml -U https://github.com/Eliora59/SelfInstall.git -vvv
fi