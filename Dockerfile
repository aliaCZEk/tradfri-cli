FROM alpine:latest
WORKDIR /tradfri-cli
COPY *.js yarn.lock package.json stats.sh ./

RUN \
  apk update && \
  apk upgrade && \
  apk --no-cache add curl jq nodejs yarn bash && \
  yarn install

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
