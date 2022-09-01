#!/bin/bash

NEAR_USER=near
DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=/home/${NEAR_USER}/.near/data
BACKUPDIR=/home/${NEAR_USER}/backups/
HC_ID=<id>
NEAR_ENV=shardnet

mkdir $BACKUPDIR


echo "Remove oldest backup if any" | ts

if [ -n "$(ls -A ${BACKUPDIR}/near_*.tar.gz 2>/dev/null)" ]
then
  rm "$(ls -t /${BACKUPDIR}/near_*.tar.gz | tail -1)"
else
  echo "empty: no backup deleted" | ts
fi

echo "End remove backup" | ts


sudo systemctl stop neard.service

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts

    tar -zcvf ${BACKUPDIR}/near_${DATE}.tar.gz $DATADIR/${NEAR_ENV}/data/

    curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/${HC_ID}

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node was started" | ts
