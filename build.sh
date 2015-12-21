#!/usr/bin/env bash

docker stop $(docker ps -q -f name=pagekite) && docker rm $(docker ps -a -q -f name=pagekite)
docker build -t pagekite .
docker run -itd --restart=always --name pagekite \
           --volume /home/local/ALTERDATA/erickleao.dnt/dsn/web/page-kite/pagekite-frontend-container/.s3cfg:/.s3cfg \
           -p 8080:80 pagekite


