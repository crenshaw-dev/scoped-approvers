#!/usr/bin/env bash

echo '| Role name | Owns | Count |' > proposal.md
echo '| --------- | ---- | ----- |' >> proposal.md
jq 'map(select(.files == ["docs"] or .files == ["USERS.md"])) | "| Docs | docs/, USERS.md | \(map(.count) | add) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["ui"] or .files == ["ui-test"] or .files == ["docs", "ui"])) | "| UI | docs/, ui/, ui-test/ | \(map(.count) | add) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["cmd"] or .files == ["cmd", "docs"] or .files == ["cmd", "docs", "test"])) | "| CLI | docs/, cmd/, test/ | \(map(.count) | add) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["resource_customizations"])) | "| Resource Customizations | resource_customizations/ | \(map(.count) | add) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["go.mod"] or .files == ["go.sum"] or .files == ["go.mod", "go.sum"])) | "| Dependencies | go.mod, go.sum | \(map(.count) | add) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == [".github"] or .files == [".github", "docs"] or .fioes == [".github", ".goreleaser.yaml"])) | "| CI | docs/, .github/, .goreleaseer.yaml | \(map(.count) | add) |"' -r pr-files-counts.json >> proposal.md
# Total of all the above
jq 'map(select(.files == ["docs"] or .files == ["USERS.md"] or .files == ["ui"] or .files == ["ui-test"] or .files == ["docs", "ui"] or .files == ["cmd"] or .files == ["cmd", "docs"] or .files == ["cmd", "docs", "test"] or .files == ["resource_customizations"] or .files == ["go.mod"] or .files == ["go.sum"] or .files == ["go.mod", "go.sum"] or .files == [".github"] or .files == [".github", "docs"] or .fioes == [".github", ".goreleaser.yaml"])) | "| Total | | \(map(.count) | add) |"' -r pr-files-counts.json >> proposal.md