#!/usr/bin/env bash

docker stop tradfri-cli
docker run -dit --rm --name tradfri-cli tradfri-cli
