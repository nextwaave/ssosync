#!/bin/bash

STACK_NAME="waave-ssosync"

function deploy_ssosync() {
  aws cloudformation deploy \
    --stack-name "${STACK_NAME}" \
    --template-file ssosync.cfn \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides "GroupMatch=${GROUP_PATTERN}"
}

function destroy_ssosync() {
  aws cloudformation delete-stack \
    --stack-name "${STACK_NAME}"

  aws cloudformation wait stack-delete-complete \
    --stack-name "${STACK_NAME}"
}

case $ACTION in
  deploy)
    deploy_ssosync  
    ;;
  destroy)
    destroy_ssosync
    ;;
  *)
    echo "No action defined"
    exit 1
    ;;
esac
