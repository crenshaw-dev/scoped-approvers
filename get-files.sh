#!/usr/bin/env bash

# Loop over the pull requests listed in open-prs.json and download the list of files changed in each PR.

set -e

echo "" > open-prs-files-raw.json

pr_numbers=$(jq -r '.[].number' open-prs.json)
length=$(jq 'length' open-prs.json)

count=1
for number in $pr_numbers; do
  # Don't bother with pagination. Few PRs have more than 100 files.
  curl -s --fail -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/argoproj/argo-workflows/pulls/$number/files?per_page=100" -H "Authorization: Bearer $token" \
    | jq --arg number "$number" '{"number": $number, "files": .}' >> open-prs-files-raw.json
  echo "Got files for PR $number, ($count of $length)"
  count=$((count+1))
done

jq --slurp '.' open-prs-files-raw.json > open-prs-files.json
