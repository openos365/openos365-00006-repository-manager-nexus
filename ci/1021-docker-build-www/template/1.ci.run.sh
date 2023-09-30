#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
cd $CMD_PATH

export MY_USER=www

docker build . -f Dockerfile \
--progress plain \
-t ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER \
-t ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest \
-t ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER \
-t ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest \
-t hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER \
-t hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest \
-t registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER \
-t registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest \
-t dockerhub.qingcloud.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER \
-t dockerhub.qingcloud.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest


# docker push ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER
# docker push ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest
# docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER
# docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER 
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest 
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest

# docker push dockerhub.qingcloud.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:$GITHUB_RUN_NUMBER
# docker push dockerhub.qingcloud.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-${MY_USER}:latest


echo "============================================================================"
