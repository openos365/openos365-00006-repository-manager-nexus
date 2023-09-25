#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
export TERM=xterm-256color
echo $PROJECT_NAME
cd $CMD_PATH
env

whoami
pwd

yum update -y
yum install epel-release -y
yum install dnf -y
dnf --assumeyes update

dnf --assumeyes install perl 
dnf --assumeyes install rsync

rsync -avzP ./root/ /


dnf clean all
dnf makecache

dnf --assumeyes install epel-release dnf-plugins-core
dnf --assumeyes upgrade epel-release

sed -e 's!^metalink=!#metalink=!g' \
    -e 's!^#baseurl=!baseurl=!g' \
    -e 's!https\?://download\.fedoraproject\.org/pub/epel!https://mirrors.tuna.tsinghua.edu.cn/epel!g' \
    -e 's!https\?://download\.example/pub/epel!https://mirrors.tuna.tsinghua.edu.cn/epel!g' \
    -i /etc/yum.repos.d/epel*.repo

# crb enable

dnf --assumeyes update

dnf --assumeyes install kiwi 
dnf --assumeyes install sudo
dnf --assumeyes install qemu-img
dnf --assumeyes install dosfstools
dnf --assumeyes install git
dnf --assumeyes install expect
dnf --assumeyes install vim
dnf --assumeyes openssh-server
dnf --assumeyes groupinstall "Development Tools"


dnf --assumeyes update
dnf clean all
dnf makecache

######## create the users www and runner=======
cat /etc/group

groupadd www
groupadd runner

useradd -m -d /home/www -G wheel -g www www -s /bin/bash
useradd -m -d /home/runner -G wheel -g runner runner -s /bin/bash

echo "root:openos365" | chpasswd
echo "runner:openos365" | chpasswd
echo "www:openos365" | chpasswd

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

mkdir -p /etc/sudoers.d
echo "www ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/www-nopassword
echo "runner ALL=(ALL) NOPASSWD: ALL"   > /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/www-nopassword
chmod 750 /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/
cat /etc/passwd
###############################################



git config --global pull.rebase false
git config --global core.editor "vim"

cd ~
if [ -d versions ];then
    rm -rf versions
fi
mkdir versions
cd versions
dnf list installed > dnf.list.installed.txt
dnf list > dnf.list.txt

sed -i '1,2d' dnf.list.installed.txt
sed -i '1d' dnf.list.txt


