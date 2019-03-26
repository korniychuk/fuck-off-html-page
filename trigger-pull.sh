#!/usr/bin/env bash

declare -r CONTROL_PHRASE='Deploy:OK'

declare RES=$( \
    curl \
        -X POST "http://${DEPLOY_TRIGGER_URL}" \
        -u "${DEPLOY_BASEAUTH_USER}:${DEPLOY_BASEAUTH_PASSWORD}" \
        --silent \
        -i
)

echo "${RES}"

if [[ ! -z $(echo "${RES}" | grep "${CONTROL_PHRASE}") ]]; then
    echo 'Pulling completed successful'
else
    echo 'Pulling finished with an error' >&2
    exit 1
fi

