#!/usr/bin/env bash
set -ex

execDBStatement() {
    echo "$1" | PGPASSWORD=$DATABASE_PASS psql \
        --host=$DATABASE_HOST \
        --port=$DATABASE_PORT \
        --username=$DATABASE_USER \
        --dbname=$MAINTENANCE_DATABASE
}

execDBStatement "SELECT 'CREATE DATABASE ${DATABASE_NAME}' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${DATABASE_NAME}')\gexec"