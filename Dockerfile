FROM ubuntu:14.04

RUN echo "deb http://pagekite.net/pk/deb/ pagekite main" > /etc/apt/sources.list.d/pagekite_net_pk_deb.list
# RUN apt-key adv --recv-keys --keyserver keys.gnupg.net AED248B1C7B2CAC3

RUN apt-get update -y \
    && apt-get install -y --allow-unauthenticated pagekite \
    s3cmd nano wget cron

COPY crontab /etc/cron.d/pagekite-cron
RUN chmod 0644 /etc/cron.d/pagekite-cron && touch /var/log/cron.log

COPY ./auto_reload.sh /
COPY ./entrypoint.sh /

CMD ["sh", "/entrypoint.sh"]
