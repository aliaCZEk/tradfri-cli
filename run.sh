#!/usr/bin/env bash

docker stop tradfri-cli
docker rm tradfri-cli
docker run -dit --rm \
  --name tradfri-cli \
  -e TRADFRIKEY=6KfxeJCySh58YEBg \
  -e TRADFRIIP=192.168.0.14 \
  -e INFLUXDBIP=192.168.0.20 \
  tradfri-cli
