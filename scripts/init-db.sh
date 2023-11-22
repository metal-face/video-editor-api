#!/usr/bin/env bash
set -e

execDBStatement() {
    echo "$1" | PGPASSWORD=$DATABASE_PASS psql \
        --host=$DATABASE_HOST \
        --port=$DATABASE_PORT \
        --username=$DATABASE_USER \
        --dbname=$DATABASE_NAME \
}

execDBStatement "SELECT 'CREATE DATABASE ${DB_NAME}' WHERE NOT EXISTS (SELECT FROM ${DB_NAME} WHERE datname = '${DB_NAME}')\gexec"