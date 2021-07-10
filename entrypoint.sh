#!/bin/sh
# entrypoint.sh
# Docker entrypoint script.

# Wait until Postgres is ready
until pg_isready -h $PG_HOST -p $PG_PORT -U $PG_USER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

bin="/opt/app/bin/server"

sh /opt/app/migrate.sh

# start the elixir application
exec "$bin" "start"
