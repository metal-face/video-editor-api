#!/usr/bin/env bash
set -e

execDBStatement() {
    echo "$1" | PGPASSWORD=$DB_PASS psql \
        --host=$DB_HOST \
        --port=$DB_PORT \
        --username=$DB_USER \
        --dbname=$DB_NAME \
}

execDBStatement "SELECT 'CREATE DATABASE ${DB_NAME}' WHERE NOT EXISTS (SELECT FROM ${DB_NAME} WHERE datname = '${DB_NAME}')\gexec"