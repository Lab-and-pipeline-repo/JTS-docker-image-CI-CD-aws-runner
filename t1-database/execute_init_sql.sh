#!/bin/bash

# Execute PostgreSQL initialization script after container is started
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/init.sql
