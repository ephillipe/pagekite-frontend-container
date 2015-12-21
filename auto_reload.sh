#!/bin/bash
CFG_FILE=/etc/pagekite.d/20_frontends.rc

OLD_MD5=$(/usr/bin/md5sum "$CFG_FILE" | awk '{print $1}')
echo 'Syncing files...'
s3cmd sync --human-readable-sizes --config=/.s3cfg s3://dnt-apps-src/pagekite/ /etc/pagekite.d/
chown root:root -R /etc/pagekite.d/

echo 'Checking...'
NEW_MD5=$(/usr/bin/md5sum "$CFG_FILE" | awk '{print $1}')

if [ "$OLD_MD5" != "$NEW_MD5" ]; then
	echo "Config file updated service will be restarted"
	ps aux | grep -i pagekite | awk {'print $2'} | xargs kill -9
	pagekite -o $CFG_FILE --clean
else
	echo "No changes detected"
fi

echo 'Done'




