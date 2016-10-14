#!/usr/bin/env bash

set -e

PGHOST=${PGHOST:=localhost}
PGPORT=${PGPORT:=5432}
PGUSER=${pguser:=postgres}
PGDATABASE=${PGDATABASE:=}

cat <<EOF
Creating Database $PGDATABASE ...

Environments:
- PGHOST: $PGHOST
- PGPORT: $PGPORT
- PGUSER: $PGUSER
- PGDATABASE: $PGDATABASE

EOF

if [ -z $PGDATABASE ]; then
    echo "Missing Database Name: Please set environment variable 'PGDATABASE'";
    exit 1
fi

if [ -z $PGPASSWORD ]; then
    echo "Please set environment variable 'PGPASSWORD' if needed";
fi

echo "Checking database server..."
until psql -w -d postgres -c "\l"; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "Initialize Database..."
if psql -lqt | cut -d \| -f 1 | grep -w " $PGDATABASE "; then
    echo "Database already exists...Skipped."
else
    createdb $PGDATABASE
    psql -d $PGDATABASE -w -c "CREATE EXTENSION postgis;"
    psql -d $PGDATABASE -w -c "CREATE EXTENSION hstore;"
fi
