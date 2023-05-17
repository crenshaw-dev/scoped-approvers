# Scoped Approvers

This repo contains research for implementing scoped approvers in Argo CD. The goal is to identify groups of PRs which
line up with certain scopes, and then to assign approvers to those scopes. This will allow us to scale the number of
approvers as the number of PRs increases.

## Generating the report/proposal

1. Get your GitHub API token (generate a PAT).
2. Run `bash generate.sh <your GitHub token>`.

The script will generate a report in [`report.md`](report.md) and a proposal in [`proposal.md`](proposal.md).
