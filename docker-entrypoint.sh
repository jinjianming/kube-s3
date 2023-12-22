#!/bin/bash
set -euo pipefail
set -o errexit
set -o errtrace
IFS=$'\n\t'

export S3_ACL=${S3_ACL:-private}

mkdir -p ${MNT_POINT}

  export AWSACCESSKEYID=${AWSACCESSKEYID:-$AWS_KEY}
  export AWSSECRETACCESSKEY=${AWSSECRETACCESSKEY:-$AWS_SECRET_KEY}

  echo "${AWS_KEY}:${AWS_SECRET_KEY}" > /etc/passwd-s3fs
  chmod 0400 /etc/passwd-s3fs

  echo 'IAM_ROLE is not set - mounting S3 with credentials from ENV'
  /usr/bin/s3fs -o url=${URL} -o allow_other -o no_check_certificate -o use_path_request_style -o umask=000 ${S3_BUCKET} ${MNT_POINT}
  echo 'started...'
