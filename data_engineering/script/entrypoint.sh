#!/bin/bash
set -e

pip install --upgrade pip


if [ -e "/opt/airflow/requirements.txt" ]; then
  pip install --user -r /opt/airflow/requirements.txt
fi

if [ ! -f "/opt/airflow/airflow-webserver.db" ]; then
  airflow db init && \
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@example.com \
    --password admin
fi

airflow db upgrade

exec airflow webserver
