#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: ./migrate-db.sh <up/down/create>"
fi

MIGRATIONS_PATH=/srv/root/migrations
MIGRATIONS_SCHEMA_TABLE=schema_migration

FULL_DB_NAME=$DB_NAME

DB_DSN="${DB_DRIVER}://${DB_PASS}@${DB_HOST}:${DB_PORT}/${FULL_DB_NAME}?x-migrations-table=${MIGRATIONS_SCHEMA_TABLE}&sslmode=disable"

case "$1" in
    up)
        echo "Running migrations up"