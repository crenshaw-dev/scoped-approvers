#!/usr/bin/env bash

# Get the most recent open pull requests from the GitHub API and write them to a single JSON list at ./open-prs.json.

echo "" > open-prs-raw.json

length=100
page=1
while [ $page -lt 11 ]; do
  curl -s -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/argoproj/argo-cd/pulls?state=open&per_page=100&page=$page" -H "Authorization: Bearer $token" > "open-prs-raw-$page.json"
  cat "open-prs-raw-$page.json" >> open-prs-raw.json
  length=$(jq '. | length' "open-prs-raw-$page.json")
  echo "Got $length open PRs"
  page=$((page+1))
done

jq --slurp 'flatten' open-prs-raw.json > open-prs.json
