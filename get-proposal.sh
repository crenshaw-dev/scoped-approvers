#!/usr/bin/env bash

echo "# Proposed Scopes" > proposal.md
echo "" >> proposal.md
echo "The Count column shows how many of the 1000 most recent PRs touch _only_ the listed files/directories." >> proposal.md
echo "" >> proposal.md
echo "The Reviewers column shows the top 3 reviewers who have reviewed the most PRs that touch the listed files/directories." >> proposal.md
echo "" >> proposal.md
echo '| Role name | Owns | Count | Reviewers |' >> proposal.md
echo '| --------- | ---- | ----- | --------- |' >> proposal.md
jq 'map(select(.files == ["go.mod"] or .files == ["go.sum"] or .files == ["go.mod", "go.sum"] or .files == ["ui/package.json"] or .files == ["ui/yarn.lock"] or .files == ["ui/package.json", "ui/yarn.lock"])) | "| Dependencies | go.mod, go.sum, ui/package.json, ui/yarn.lock | \(map(.count) | add) | \(map(.reviewers) | flatten | group_by(.user) | map({user: .[0].user, count: (map(.count) | add)}) | sort_by(.count) | reverse | .[:3] | map("\(.user) (\(.count))") | join(", ")) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["ui"] or .files == ["ui-test"] or .files == ["docs", "ui"] or .files == ["ui/package.json"] or .files == ["ui/yarn.lock"] or .files == ["ui/package.json", "ui/yarn.lock"])) | "| UI | ui/, ui-test/ | \(map(.count) | add) | \(map(.reviewers) | flatten | group_by(.user) | map({user: .[0].user, count: (map(.count) | add)}) | sort_by(.count) | reverse | .[:3] | map("\(.user) (\(.count))") | join(", ")) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["docs"] or .files == ["USERS.md"] or .files == ["mkdocs.yml"] or .files == ["docs", "mkdocs.yml"] or .files == [".spelling"])) | "| Docs | docs/, mkdocs.yml, USERS.md, .spelling | \(map(.count) | add) | \(map(.reviewers) | flatten | group_by(.user) | map({user: .[0].user, count: (map(.count) | add)}) | sort_by(.count) | reverse | .[:3] | map("\(.user) (\(.count))") | join(", ")) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == [".github"] or .files == [".github", "docs"] or .files == [".github", ".goreleaser.yaml"])) | "| CI | .github/, .goreleaseer.yaml | \(map(.count) | add) | \(map(.reviewers) | flatten | group_by(.user) | map({user: .[0].user, count: (map(.count) | add)}) | sort_by(.count) | reverse | .[:3] | map("\(.user) (\(.count))") | join(", ")) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["workflow/controller"] or .files == ["workflow/controller", "test"])) | "| Controller | workflow/controller/, test/ | \(map(.count) | add) | \(map(.reviewers) | flatten | group_by(.user) | map({user: .[0].user, count: (map(.count) | add)}) | sort_by(.count) | reverse | .[:3] | map("\(.user) (\(.count))") | join(", ")) |"' -r pr-files-counts.json >> proposal.md
jq 'map(select(.files == ["workflow/artifacts"] or .files == ["workflow/artifacts", "test"])) | "| Artifacts | workflow/artifacts/, test/ | \(map(.count) | add) | \(map(.reviewers) | flatten | group_by(.user) | map({user: .[0].user, count: (map(.count) | add)}) | sort_by(.count) | reverse | .[:3] | map("\(.user) (\(.count))") | join(", ")) |"' -r pr-files-counts.json >> proposal.md
