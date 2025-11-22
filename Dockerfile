ARG ARCH="amd64"
ARG OS="linux"
FROM alpine:3.22

RUN apk add smartmontools gpg gpg-agent curl

COPY --from=quay.io/prometheuscommunity/smartctl-exporter:v0.14.0 /bin/smartctl_exporter /bin/smartctl_exporter

RUN update-smart-drivedb

EXPOSE      9633
USER        nobody
ENTRYPOINT  [ "/bin/smartctl_exporter" ]
