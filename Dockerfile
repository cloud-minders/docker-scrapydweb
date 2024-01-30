FROM python:3.6-alpine
LABEL description="Web app for Scrapyd cluster management, Scrapy log analysis & visualization, Auto packaging, Timer tasks, Monitor & Alert, and Mobile UI."

ENV PYTHONUNBUFFERED 1

RUN set -ex && apk --no-cache --virtual .build-deps add dumb-init build-base g++ bash curl gcc libgcc tzdata psutils linux-headers openssl-dev postgresql-dev libffi-dev libxml2-dev libxslt-dev

RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
RUN echo "America/New_York" > /etc/timezone

RUN pip install -U pip
RUN pip install scrapydweb psycopg2

RUN mkdir /scrapyd
COPY scrapydweb_settings_v10.py /scrapyd/
WORKDIR /scrapyd/

ADD https://raw.githubusercontent.com/cloud-minders/wait-for-it/master/wait-for-it.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wait-for-it.sh

EXPOSE 5000

ENTRYPOINT ["scrapydweb"]
