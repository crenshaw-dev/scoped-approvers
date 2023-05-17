#!/usr/bin/env bash

# Use jq to list the top-level directories in the list of files for each PR.

jq 'map({number: .number, files: (.files | map(.filename | split("/")[0]) | unique | sort)}) | group_by(.files) | map({count: length, numbers: map(.number), files: .[0].files}) | sort_by(.count) | reverse' open-prs-files.json > pr-files-counts.json
