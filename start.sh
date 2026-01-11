#!/bin/bash

export MINIO_ROOT_USER=$S3_ACCESS_KEY
export MINIO_ROOT_PASSWORD=$S3_SECRET_KEY

minio server /data --address ":9000" &
sleep 5

unkey agent
