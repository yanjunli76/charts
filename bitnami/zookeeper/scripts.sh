#!/bin/bash
set -xe

#Replace with your ips 
work1=10.160.27.181
work2=10.185.18.92
work3=10.161.119.118

ssh-copy-id root@$work1 -o "StrictHostKeyChecking no"
ssh-copy-id root@$work2 -o "StrictHostKeyChecking no"
ssh-copy-id root@$work3 -o "StrictHostKeyChecking no"

app=zookeeper

create() {
    command1="mkdir -p /mnt/disk/$app && mount -t tmpfs -o size=10G $app /mnt/disk/$app/"
    for ip in $work1 $work2 $work3; do
        ssh root@$ip $command1
    done
}

delete() {
    command1="rm -rf /mnt/disk/$app/*"
    for ip in $work1 $work2 $work3; do
        ssh root@$ip $command1
    done
}



case "$1" in
  (create) 
    create
    exit 0
    ;;
  (delete)
    delete
    exit 0
    ;;
  (*)
    echo "Usage: $0 {create|delete}"
    exit 1
    ;;
esac