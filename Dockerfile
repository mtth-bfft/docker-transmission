FROM alpine:3.5
LABEL maintainer "Matthieu Buffet <mtth.bfft@gmail.com>"

RUN apk add --no-cache \
    transmission-daemon \
    curl

ENV complete_dir=/data/downloads incomplete_dir=/data/incomplete

# Create world-writable directories for transmission state
# (we don't know in advance the UID transmission-daemon will run with,
# and it's safe since there'll only ever be one user in this container)
RUN mkdir -p /etc/transmission/ ${complete_dir} ${incomplete_dir} && \
	chmod -R 777 /etc/transmission/ ${complete_dir} ${incomplete_dir}

# Default to prevent running as root if no --user or user namespace set up
USER transmission

VOLUME ["${incomplete_dir}", "${complete_dir}"]

CMD ["/usr/bin/transmission-daemon","-f","-g","/etc/transmission/"]

EXPOSE 9091 51413

HEALTHCHECK CMD curl --connect-timeout 1 --silent localhost:9091 >/dev/null

COPY settings.json /etc/transmission/
