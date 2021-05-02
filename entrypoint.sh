#!/usr/bin/env bash
set -e

export SSOSYNC_GOOGLE_CREDENTIALS="/tmp/credentials.json"
aws ssm get-parameter --with-decryption --output text --name ${GOOGLECREDENTIALS} --query Parameter.Value > /tmp/credentials.json

export SSOSYNC_GOOGLE_ADMIN=$(aws ssm get-parameter --with-decryption --output text --name ${GOOGLEADMINEMAIL} --query Parameter.Value)
export SSOSYNC_SCIM_ENDPOINT=$(aws ssm get-parameter --with-decryption --output text --name ${SCIMENDPOINTURL} --query Parameter.Value)
export SSOSYNC_SCIM_ACCESS_TOKEN=$(aws ssm get-parameter --with-decryption --output text --name ${SCIMENDPOINTACCESSTOKEN} --query Parameter.Value)
export SSOSYNC_GROUP_MATCH=${GROUP_MATCH}

/var/task/ssosync -d
