#!/usr/bin/env bash

# parse request path
state_id=$(<<<"$PATH_INFO" sed -n -E 's,/terraform/state/([^/]+).*,\1,p')

if [ -z "$state_id" ]; then
  cat <<EOF
Status: 400

EOF
  exit
fi

# parse request parameters
declare -A param
while IFS='=' read -r -d '&' key value && [[ -n "$key" ]]; do
    param["$key"]=$value
done <<<"${QUERY_STRING}&"

if stat "states/$state_id.lock" >/dev/null 2>&1; then
  lock_id="$(jq -r '.ID' "states/$state_id.lock")"
fi

# Fail saving state with a 403 Forbidden
# if known lock id doesn't match ID coming in the request
if [[ "${lock_id:-}" != "${param["ID"]}" ]]; then
  cat <<-EOF
Status: 423

EOF
  exit
fi

# save incoming state
cat /dev/stdin > "states/$state_id.tfstate"
