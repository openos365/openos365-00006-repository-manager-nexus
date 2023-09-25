#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

docker pull openos365/openos365-10001-anolisos-7-docker-main:latest
docker run -it -v ./:/code -w /code openos365/openos365-10001-anolisos-7-docker-main:latest bash
