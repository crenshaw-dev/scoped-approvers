#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 <GitHub API token>"
  exit 1
fi

token=$1

#token=$token bash get-pull-requests.sh
#token=$token bash get-files.sh
#token=$token bash get-comments.sh
bash get-top-level-dirs.sh
bash get-report.sh
bash get-proposal.sh
