FROM ubuntu:14.04

ENV AWS_KEY ""
ENV AWS_SECRET ""

RUN echo "deb http://pagekite.net/pk/deb/ pagekite main" > /etc/apt/sources.list.d/pagekite_net_pk_deb.list
RUN apt-key adv --recv-keys --keyserver keys.gnupg.net AED248B1C7B2CAC3

RUN apt-get update -y
RUN apt-get install -y pagekite
RUN pip install s3cmd
RUN s3cmd sync /etc/pagekite.d/ s3://dnt-apps-src/pagekite --access_key=${AWS_KEY} --secret_key=${AWS_SECRET}

# RUN rm /etc/pagekite.d/20_frontends.rc

# pagekite.net service
CMD service pagekite restart
