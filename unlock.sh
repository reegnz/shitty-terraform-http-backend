#!/usr/bin/env bash

# parse request path
state_id=$(<<<"$PATH_INFO" sed -n -E 's,/terraform/lock/state/([^/]+).*,\1,p')

if [ -z "$state_id" ]; then
  cat <<EOF
Status: 400

EOF
  exit
fi

# remove lock if exists
if stat "states/$state_id.lock"; then
  rm -rf "states/$state_id.lock"
fi
