#!/bin/bash

NEAR_USER=near
RESTOREDATE=$(date +%Y-%m-%d-%H-%M)
BACKUPDIR=/home/${NEAR_USER}/backups/
DATADIR=/home/${NEAR_USER}/.near/data

# Check if restore date env variable is set otherwise get last folder
if [[ -z "${RESTORE_DATE}" ]]; then
  SOURCE_DIR=$(ls -t /${DATADIR}/near_*.tar.gz | head -1)
else
  DATE="${RESTORE_DATE}"
  SOURCE_DIR=${BACKUPDIR}/near_${DATE}.tar.gz
fi

sudo systemctl stop neard.service

wait

echo "NEAR node was stopped" | ts

if [ -f "$SOURCE_DIR" ]; then
    echo "Restore started" | ts

    mkdir $DATADIR/$NEAR_ENV/data_$RESTOREDATE/
    mv -r $DATADIR/$NEAR_ENV/data/* $DATADIR/$NEAR_ENV/data_$RESTOREDATE/
    
    tar xf ${BACKUPDIR}/near_${DATE}.tar.gz $DATADIR/${NEAR_ENV}/data/
    
    echo "Restore completed" | ts
else
    echo $SOURCE_DIR does not exist. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node was started" | ts