FROM alpine

RUN apk add --no-cache icecast mailcap curl
RUN mkdir /etc/icecast \
    && chown icecast:icecast /etc/icecast

ADD ./start.sh /start.sh
USER icecast

HEALTHCHECK --start-period=60s --interval=10s --timeout=3s --retries=6 \
  CMD curl -I -X GET --fail-with-body http://localhost:8000/stream || exit 1

EXPOSE 8000
VOLUME ["/var/log/icecast"]
CMD ["/start.sh"]