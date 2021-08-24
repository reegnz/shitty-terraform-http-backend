#!/usr/bin/env bash

# parse request path
state_id=$(<<<"$PATH_INFO" sed -n -E 's,/terraform/state/([^/]+).*,\1,p')

if [ -z "$state_id" ]; then
  cat <<EOF
Status: 400

EOF
  exit
fi

# return state if found
if stat "states/$state_id.tfstate" >/dev/null 2>&1 ; then
  cat "states/$state_id.tfstate"
else
  cat <<EOF
Status: 404

EOF
  exit
fi
