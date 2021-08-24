#!/usr/bin/env bash

mkdir -p states

shell2http -cgi \
  GET:/terraform/state/ ./get.sh \
  POST:/terraform/state/ ./post.sh \
  DELETE:/terraform/state/ ./delete.sh \
  POST:/terraform/lock/state/ ./lock.sh \
  DELETE:/terraform/lock/state/ ./unlock.sh
