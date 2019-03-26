#!/usr/bin/env bash

set -euxo pipefail
declare -r CONTROL_PHRASE='Deploy:OK'

echo;
echo '----- BEGIN Triggering docker pull -----'
echo;

declare RES=$( \
    curl \
        -X POST "http://${DEPLOY_TRIGGER_URL}" \
        -u "${DEPLOY_BASEAUTH_USER}:${DEPLOY_BASEAUTH_PASSWORD}" \
        --silent \
        -i
)

echo "${RES}"

echo '----- END Triggering docker pull -----'

if [[ ! -z $(echo "${RES}" | grep "${CONTROL_PHRASE}") ]]; then
    echo 'Pulling completed successful'
else
    echo 'Pulling finished with an error' >&2
    exit 1
fi

