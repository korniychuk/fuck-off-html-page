#!/usr/bin/env bash

set -euo pipefail

declare -r CONTROL_PHRASE='Deploy:OK'

echo -e '\n----- BEGIN Triggering docker pull -----\n'

declare RES=$( \
    curl \
        -X POST "${DEPLOY_TRIGGER_URL}" \
        -u "${DEPLOY_BASEAUTH_USER}:${DEPLOY_BASEAUTH_PASSWORD}" \
        --silent \
        -i
)

echo "${RES}"

echo -e '\n----- END Triggering docker pull -----\n'

if [[ ! -z $(echo "${RES}" | grep "${CONTROL_PHRASE}") ]]; then
    echo 'Pulling completed successful'
else
    echo 'Pulling finished with an error' >&2
    exit 1
fi

