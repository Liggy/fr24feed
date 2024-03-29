FROM debian:bullseye-slim

ADD feed-dl /usr/bin/feed-dl

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install procps librtlsdr0 librtlsdr-dev wget unzip build-essential pkg-config ca-certificates && \
    wget https://github.com/Liggy/dump1090/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    cd dump1090-master && \
    make && \
    cp -a dump1090 view1090 public_html /usr/bin && \
    cd / && \
    rm -r /dump1090-master && \
    '.' '/usr/bin/feed-dl' && \
    rm /usr/bin/feed-dl && \
    apt-get -y purge librtlsdr-dev wget unzip build-essential pkg-config && \
    apt-get --purge -y autoremove && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

ADD fr24feed.ini /etc/fr24feed.ini

EXPOSE 8080 8754 30001-30005

ENTRYPOINT ["fr24feed"]
