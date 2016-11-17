FROM alpine:3.4
MAINTAINER Matthieu Buffet <mtth.bfft@gmail.com>

RUN apk add --no-cache \
    transmission-daemon \
    bash \
    curl

CMD ["/usr/bin/transmission-daemon","-f","-g","/etc/transmission/"]

EXPOSE 9091 51413

HEALTHCHECK CMD curl --connect-timeout 1 --silent localhost:9091 >/dev/null

RUN mkdir -p /etc/transmission/ /data/downloads/

COPY settings.json /etc/transmission/
