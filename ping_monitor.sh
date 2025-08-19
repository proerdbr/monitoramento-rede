#!/bin/bash

hosts=("8.8.8.8" "1.1.1.1")

for host in "${hosts[@]}"
do
    if ping -c 2 "$host" > /dev/null; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $host está online"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $host está offline"
    fi
done
