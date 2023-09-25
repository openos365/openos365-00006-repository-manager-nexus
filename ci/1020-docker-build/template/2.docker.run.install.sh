#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

docker pull openanolis/anolisos:7.9-x86_64

docker run -i -v ./:/code -w /code openanolis/anolisos:7.9-x86_64 /code/files/install.sh
