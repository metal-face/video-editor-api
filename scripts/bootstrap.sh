#!/usr/bin/env bash
set -eo pipefail

if [ -z "$APP_ENV" ]; then
    echo "Please set APP_ENV"
    exit 1
fi

cd /srv/root

if [ -z "$APP_COMPONENT" ]; then
    echo "Please set APP_COMPONENT"
    exit 1
fi

# await database availability
/scripts/await-service.sh $DATABASE_HOST $DATABASE_PORT $SERVICE_READINESS_TIMEOUT

/scripts/init-db.sh

#  TODO: run migrations
diesel migration run

cargo run

# run the service
# /usr/localbin/video-editor-api