#!/usr/bin/env bash

# parse request path
state_id=$(<<<"$PATH_INFO" sed -n -E 's,/terraform/lock/state/([^/]+).*,\1,p')

if [ -z "$state_id" ]; then
  cat <<EOF
Status: 400

EOF
  exit
fi

# check if lock exists
if stat "states/$state_id.lock" >/dev/null 2>&1; then
  cat <<-EOF
Status: 409

EOF
  # echo back existing lock info
  cat "states/$state_id.lock"
else
  # save lock
  cat /dev/stdin > "states/$state_id.lock"
fi
