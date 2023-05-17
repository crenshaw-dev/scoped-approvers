#!/usr/bin/env bash


echo "| Count | Directories | Examples |" > report.md
echo "| ----- | ----------- | -------- |" >> report.md
jq '.[] | "| \(.count) | \(.files | join(", ")) | |"' -r pr-files-counts.json >> report.md
