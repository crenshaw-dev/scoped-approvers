# Scoped Approvers

For now, any Approver can merge any PR. This means there is a high barrier to entry to being an Approver.

The gap between opened PRs and merged PRs continues to grow. This is bad because 1) improvements don't get merged, and 2)
active contributors get frustrated and stop contributing.

Many PRs touch a small subset of the argo-cd top level directories, or just a few key files. The barrier to entry for 
merging these PRs should be lower than full-Approver status.

## Possible Solution

Promote "scoped Approvers" and enforce scopes via GitHub CODEOWNERS rules. Scoped Approvers can merge PRs that touch
only the files/directories they own.

Promoting scoped Approvers does not require governance changes. The existing governance documentation already assumes
using CODEOWNERS to scope the Reviewer and Approver roles.

For this change to be worth the overhead, we need to establish that 1) a significant number of PRs fit into reasonable
scopes, and 2) there are people who make sense as scoped Approvers.

## Analysis

I pulled the 1000 most recent PRs from the argo-cd repo. I then grouped them by the top level directories they touch 
(and some one-off files, like ui/package.json). I then grouped and counted these PRs. The raw counts are in 
[report.md](report.md).

I found some high-count groups and lumped similar ones together. I then looked at the top 3 reviewers for each group.
These statistics are in [report.md](report.md) and duplicated here:

| Role name | Owns | Count | Reviewers |
| --------- | ---- | ----- | --------- |
| **Docs** | docs/, mkdocs.yml, USERS.md | 234 | blakepettersson (38), morey-tech (12), 34fathombelow (8) |
| UI | ui/, ui-test/ | 123 | n9 (5), ashutosh16 (5), alexef (5) |
| **Dependencies** | go.mod, go.sum, ui/package.json, ui/yarn.lock | 117 |  |
| **CI** | .github/, .goreleaseer.yaml | 66 | 34fathombelow (17), morey-tech (2), blakepettersson (2) |
| ApplicationSet | applicationset/ | 45 | ishitasequeira (6) |

## Proposal

1. Update the argo-cd CODEOWNERS file to include these scopes: All, Docs, Dependencies, CI (consider ApplicationSet later).
2. Add all current Approvers to the All scope.
3. Update the argo-cd branch protections to require CODEOWNERS approval for all PRs.
4. At the next membership meeting, consider the following promotions:
   - blakepettersson to Approver for the Docs scope
   - morey-tech to Reviewer for the Docs scope
   - 34fathombelow to Approver for the CI, Dependencies, and Docs scopes

## Pros/Cons

Pros:
* More PRs get merged.
* Lower barrier of entry for moving up the "contributor ladder".
* PR authors feel like their work is being valued.

Cons:
* Management overhead.
* CODEOWNERS notifications being noisy.
* Too many maintainers?
