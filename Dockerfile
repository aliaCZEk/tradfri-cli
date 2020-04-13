FROM alpine:latest
WORKDIR /tradfri-cli
COPY *.js yarn.lock package.json stats.sh ./

ENV \
  TRADFRIKEY=6KfxeJCySh58YEBg \
  TRADFRIIP=192.168.0.14 \
  INFLUXDBIP=192.168.0.10

RUN \
  apk update && \
  apk upgrade && \
  apk --no-cache add curl jq nodejs yarn bash && \
  yarn install

CMD ["/bin/bash"]