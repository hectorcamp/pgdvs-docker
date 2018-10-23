FROM alpine:3.7
MAINTAINER RXWatcher

# Set version label
ARG BUILD_DATE
ARG VERSION

RUN apk add --no-cache --update python tini bash git 

# Add local files
COPY root/ /

WORKDIR /config/pgdvs/

ENTRYPOINT ["tini", "--", "python", "default.py"]
CMD ["/config/pgdvs/gdrive.db"]
VOLUME /config
EXPOSE 9988
