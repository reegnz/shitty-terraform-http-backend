#!/usr/bin/env bash

# parse request path
state_id=$(<<<"$PATH_INFO" sed -n -E 's,/terraform/state/([^/]+).*,\1,p')

if [ -z "$state_id" ]; then
  cat <<EOF
Status: 400

EOF
  exit
fi

# delete state if found
if stat "states/$state_id.tfstate" >/dev/null 2>&1 ; then
  rm "states/$state_id.tfstate"
fi
