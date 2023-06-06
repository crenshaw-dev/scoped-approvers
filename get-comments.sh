#!/usr/bin/env bash

#echo "" > pr-reviews-raw.json
#
## Loop over PRs by number.
#pr_numbers=$(jq -r '.[].number' open-prs.json)
#number_of_prs=$(jq 'length' open-prs.json)
#
#count=1
#for number in $pr_numbers; do
#  curl -s -H "Authorization: Bearer $token" -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/argoproj/argo-workflows/pulls/$number/reviews" >> "pr-reviews-raw.json"
#  echo -en "\rGot reviews for PR $number ($count of $number_of_prs)"
#  count=$((count+1))
#done
#
#jq --slurp '.' pr-reviews-raw.json > pr-reviews.json

jq 'flatten | map({user: .user.login, number: (.pull_request_url | sub(".*/"; ""))}) | group_by(.number) | map({number: .[0].number, users: map(.user | . as $user | select(["sarabala1979", "alexec", "edlee2121", "alexmt", "jessesuen", "terrytangyuan", "juliev0", "github-actions[bot]"] | index($user) | not)) | sort | unique})' pr-reviews.json > reviewers-by-pr.json
