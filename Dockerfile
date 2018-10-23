FROM alpine:3.7
MAINTAINER RXWatcher

# Set version label
ARG BUILD_DATE
ARG VERSION

RUN apk add --update python tini
WORKDIR /config/pgdvs/

ENTRYPOINT ["tini", "--", "python", "default.py"]
CMD ["/config/pgdvs/gdrive.db"]
VOLUME /config
EXPOSE 9988
