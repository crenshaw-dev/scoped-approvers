#!/usr/bin/env bash

# Use jq to list the top-level directories in the list of files for each PR.

jq 'map(
  {
    number: .number,
    # Get the top-level directories for each file. package.json and yarn.lock are treated as their own thing.
    files: (.files | map(.filename | if (endswith("package.json") or endswith("yarn.lock")) then . else split("/")[0] end) | unique | sort | if (. == ["docs"] or . == ["docs", "USERS.md"] or . == ["USERS.md"]) then . else . - ["docs", "USERS.md"] end)
  }
) | group_by(.files)
  | map(
    {
      count: length,
      numbers: map(.number),
      files: .[0].files,
      reviewers: (
        ((map(.number) as $numbers | $reviewers_by_pr[0] | map(select(.number as $number | $numbers | contains([$number])) | .users))) as $all_users | $all_users
        | flatten | sort | unique |
          map({
              user: .,
              count: (. as $user | $all_users | map(select(contains([$user]))) | length)
            } | select(.count > 1)
          ) | sort_by(.count) | reverse
        )
  }
) | sort_by(.count) | reverse' open-prs-files.json --slurpfile reviewers_by_pr reviewers-by-pr.json > pr-files-counts.json
