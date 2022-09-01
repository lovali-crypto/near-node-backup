# near-node-backup

Script to backup and restore a Near node database.
The script remove the oldest backup and creates a .tar.gz archive containing the DB and storing to a defined location.

## How to use it

Schedule the backup script using a crontab.
Set the healthcheck.io ID in order to monitor the execution. Create the healthcheck.io configuration to match the crontab schedule

## Restore

The restore script is extracting the .tar.gz archive created by the backup script.
If you want to restore to a different machine make sure you rsync with mirror option the backup folder of the backup server to your main NEAR server.