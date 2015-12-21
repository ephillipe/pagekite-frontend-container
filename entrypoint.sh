#!/bin/bash

s3cmd sync --human-readable-sizes --config=/.s3cfg s3://dnt-apps-src/pagekite/ /etc/pagekite.d/
cron
pagekite -o /etc/pagekite.d/20_frontends.rc --logfile=stdio --debugio --clean
