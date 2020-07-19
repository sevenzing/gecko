#!/bin/bash

echo "RECREATE NGINX CONFIG"
envsubst < /etc/nginx/conf.d/nginx.template > /etc/nginx/conf.d/default.conf
echo "START NGINX"
service nginx start
echo "START NODE WITH ARGS ${AVA_CMD_OPTIONS}"
./build/ava ${AVA_CMD_OPTIONS}
