ARG ARCH="amd64"
ARG OS="linux"
FROM alpine:3.23 AS base

RUN apk add smartmontools

COPY --from=quay.io/prometheuscommunity/smartctl-exporter:v0.14.0 /bin/smartctl_exporter /bin/smartctl_exporter

# -----------

FROM base AS update

RUN apk add gpg gpg-agent curl
RUN update-smart-drivedb

# -----------

FROM base AS run

COPY --from=update /usr/share/smartmontools/drivedb.h /usr/share/smartmontools/drivedb.h

EXPOSE      9633
USER        nobody
ENTRYPOINT  [ "/bin/smartctl_exporter" ]
