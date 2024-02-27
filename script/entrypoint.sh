#!/usr/bin/env bash
set -e

# shellcheck disable=SC1009
# shellcheck disable=SC1073
if [ -e "/opt/airflow/requirements.txt" ]; then
    $(command -v pip) install --user -r requirements.txt
fi

# Init the db
# shellcheck disable=SC1009
# shellcheck disable=SC1073
if [ ! -f "/opt/airflow/airflow.db" ]; then
  airflow db init && \
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@airscholar.com \
    --password admin
fi

$(command -v airflow) db upgrade

exec airflow webserver
