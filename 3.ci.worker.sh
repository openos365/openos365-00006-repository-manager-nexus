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
if [ ! -z "${GITHUB_REPOSITORY}" ];then

sudo df -h
sudo rm -rf /usr/local/lib/android # will release about 10 GB if you don't need Android
sudo rm -rf /usr/share/dotnet # will release about 20GB if you don't need .NET

# sudo docker image prune --all --force

# https://github.com/jlumbroso/free-disk-space/blob/main/action.yml
sudo rm -rf /opt/ghc

sudo apt-get remove -y '^dotnet-.*'
sudo apt-get remove -y '^llvm-.*'
sudo apt-get remove -y 'php.*'
sudo apt-get remove -y '^mongodb-.*'
sudo apt-get remove -y '^mysql-.*'
sudo apt-get remove -y azure-cli google-cloud-sdk google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri
sudo apt-get autoremove -y
sudo apt-get clean
echo "$AGENT_TOOLSDIRECTORY"
sudo rm -rf "$AGENT_TOOLSDIRECTORY"
sudo df -h

    # 0
    # sudo apt update -y
    # sudo apt upgrade -y
    sudo apt install -y dos2unix
    cd ~
    curl -LO https://storage.googleapis.com/container-diff/latest/container-diff-linux-amd64
    sudo install container-diff-linux-amd64 /usr/bin/container-diff
    cd $CMD_PATH
    
    # 1 
    git config --global user.email "gnuhub@gmail.com"
    git config --global user.name "gnuhub"

    # 2
    git remote -v
    git remote set-url origin git@github.com:${GITHUB_REPOSITORY}.git
    git remote -v

    # 3
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R "frs.sourceforge.net"
    ssh-keyscan "frs.sourceforge.net" >> $HOME/.ssh/known_hosts
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R "github.com"
    ssh-keyscan "github.com" >> $HOME/.ssh/known_hosts
    cat $HOME/.ssh/known_hosts

    # 4
    curl https://raw.githubusercontent.com/openos365/openos365-00002-ci-github-actions-template/main/6.template.update.from.00002.sh > 6.template.update.from.00002.sh
    chmod +x 6.template.update.from.00002.sh
    sudo cp ./6.template.update.from.00002.sh /usr/bin/6.template.update.from.00002.sh
    6.template.update.from.00002.sh
    sudo cp ./p2 /usr/bin/p2

    # 5
    cd $CMD_PATH
    p2 "CI-BOT:$(date +%Y.%m.%d-%H%M%S)-$GITHUB_REF_NAME-$GITHUB_RUN_NUMBER"


    # 6
    cd $CMD_PATH
    for ci_dir in `ls -d -1 ci/1* | sort`
    do
        echo $ci_dir
        if [ -f $ci_dir/1.ci.run.sh ];then
            ./${ci_dir}/1.ci.run.sh
        fi
    done

    # 7
    # cd $CMD_PATH
    # apt list > 4.apt.list.txt
    # apt list --installed > 5.apt.list.installed.txt
   
    # 8
    cd $CMD_PATH
    touch 8.workflows.to.run.repos.txt
    dos2unix 8.workflows.to.run.repos.txt
    while read repo
    do
        echo $repo | tr -d '\r'
        export repo_name=$(echo $repo | tr -d '\r')
        echo $repo_name
        if [ ! -z $repo_name ];then 
            export repo_name_length=$(expr length ${repo_name})
            echo $repo_name_length
            if [ $repo_name_length -gt 3 ];then
                gh workflow run 1.ci.yml --repo $repo_name --ref $GITHUB_REF_NAME
            fi
        fi
    done < 8.workflows.to.run.repos.txt

    # 9
    sudo find ./ -name "*.sh" -exec sudo chmod +x {} \; 
    p2 "CI-BOT:$(date +%Y.%m.%d-%H%M%S)-$GITHUB_REF_NAME-$GITHUB_RUN_NUMBER"
    

fi
echo "============================================================================"
