#!/usr/bin/env bash
set -e

export SSOSYNC_GOOGLE_CREDENTIALS="/tmp/credentials.json"
aws ssm get-parameter --with-decryption --output text --name ${1} --query Parameter.Value > /tmp/credentials.json

export SSOSYNC_GOOGLE_ADMIN=$(aws ssm get-parameter --with-decryption --output text --name ${2} --query Parameter.Value)
export SSOSYNC_SCIM_ENDPOINT=$(aws ssm get-parameter --with-decryption --output text --name ${3} --query Parameter.Value)
export SSOSYNC_SCIM_ACCESS_TOKEN=$(aws ssm get-parameter --with-decryption --output text --name ${4} --query Parameter.Value)

/var/task/ssosync -d -g "${GROUP_MATCH}"
