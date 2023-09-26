#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

echo "============================================================================"
pwd

echo "============================================================================"
whoami

echo "============================================================================"
env

echo "============================================================================"
# TODO HERE

echo "openos365">/etc/hostname

cd /etc/
if [ -d versions ];then
    rm -rf versions
fi
mkdir versions
cd versions

function dnf_list()
{

    dnf list installed > dnf.list.installed.txt
    dnf list > dnf.list.txt

    sed -i '1,2d' dnf.list.installed.txt
    sed -i '1d' dnf.list.txt
}

function apt_list()
{

    apt list --installed > apt.list.installed.txt
    apt list > apt.list.txt

    sed -i '1,2d' apt.list.installed.txt
    sed -i '1d' apt.list.txt
}
which dnf
if [ $? -eq 0 ];then
    dnf_list
fi

which apt
if [ $? -eq 0 ];then
    apt_list
fi

cd $CMD_PATH
rsync -avzP --delete \
--exclude=/hosts \
--exclude=/openldap/certs/ \
--exclude=/resolv.conf \
--exclude=/shadow \
--exclude=/pki/ca-trust/extracted/java/cacerts \
--exclude=/shadow- \
--exclude=/machine-id \
--exclude=/sgml/ \
--exclude=/dconf/db/site \
--exclude=/iscsi/initiatorname.iscsi \
--exclude=/nvme/hostid \
--exclude=/nvme/hostnqn \
/etc/ ./etc/
chmod -R 777 ./etc/

echo "============================================================================"
