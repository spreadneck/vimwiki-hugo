#!/usr/bin/env bash
set -euo pipefail

SRC_BRANCH="$1"
DST_BRANCH="$2"
PR_TITLE="$3"

# Enforce branch naming conventions: feature/*, hotfix/*, release/*
if ! [[ "$SRC_BRANCH" =~ ^(feature|hotfix|release)/.+$ ]]; then
    echo "::error::Branch '$SRC_BRANCH' does not follow Gitflow naming (feature/*, hotfix/*, release/*)"
    exit 1
fi

# Block feature/* --> main
if [[ "$SRC_BRANCH" =~ ^feature/ ]] && [[ "$DST_BRANCH" == "main" ]]; then
    echo "::error::You cannot merge feature branches directly to main! Merge into develop."
    exit 1
fi
# Block hotfix/* --> develop
if [[ "$SRC_BRANCH" =~ ^hotfix/ ]] && [[ "$DST_BRANCH" == "develop" ]]; then
    echo "::error::You cannot merge hotfix branches directly to develop! Merge into main."
    exit 1
fi
# Block release/* --> any branch but main or develop
if [[ "$SRC_BRANCH" =~ ^release/ ]] && [[ ! "$DST_BRANCH" =~ ^(main|develop)$ ]]; then
    echo "::error::Release branches can only be merged into main or develop."
    exit 1
fi

# Enforce Conventional Commit in PR title
if ! [[ "$PR_TITLE" =~ ^(feat|fix|docs|style|refactor|perf|test|chore|build|ci|revert)(\([a-z0-9\-]+\))?!?:\ .+ ]]; then
    echo "::error::PR title must follow Conventional Commit (e.g. feat: add login, fix(api): handle bug)"
    exit 1
fi
