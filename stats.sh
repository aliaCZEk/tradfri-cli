#!/usr/bin/env bash

data=""
while read -r i; do
  name=$(echo ${i} | jq -r '.name' | sed 's/ /_/g')
  battery=$(echo ${i} | jq '.battery')

  data=$(echo -e "${data}\ntradfri,name=${name} value=${battery}")
done <<<$(node devices.js | jq -c '.[]' | grep battery | jq -c)

curl -XPOST -s "http://${INFLUXDBIP}:8086/write?db=mydb" --data-binary "${data}"
