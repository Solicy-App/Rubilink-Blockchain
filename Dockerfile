FROM python:3.6
LABEL maintainer "contact@ipdb.global"
RUN mkdir -p /usr/src/app
COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN apt-get -qq update \
    && apt-get -y upgrade \
    && apt-get install -y jq \
    && pip install . \
    && apt-get autoremove \
    && apt-get clean

VOLUME ["/data", "/certs"]

ENV PYTHONUNBUFFERED 0
ENV BIGCHAINDB_CONFIG_PATH /data/.bigchaindb
ENV BIGCHAINDB_SERVER_BIND 0.0.0.0:3333
ENV BIGCHAINDB_WSSERVER_HOST 0.0.0.0
ENV BIGCHAINDB_WSSERVER_SCHEME ws
ENV BIGCHAINDB_WSSERVER_ADVERTISED_HOST 0.0.0.0
ENV BIGCHAINDB_WSSERVER_ADVERTISED_SCHEME ws
ENV BIGCHAINDB_WSSERVER_ADVERTISED_PORT 3333
ENTRYPOINT ["bigchaindb"]
CMD ["start"]
