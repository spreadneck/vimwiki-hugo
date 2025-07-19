#!/usr/bin/env bash

# bump_version.sh: Bump VERSION, update CHANGELOG.md, and retag latest for new release.
# Usage: ./bin/bump_version.sh <NEW_VERSION>

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <NEW_VERSION>" >&2
  exit 1
fi

NEW_VERSION="$1"

if ! [[ "$NEW_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]{4}\.[0-9]{2}\.[0-9]{2}\.[0-9]+$ ]]; then
  echo "Error: Version must match MAJOR.MINOR.YYYY.MM.DD.PATCH format" >&2
  exit 1
fi

CUR_VERSION="$(cat VERSION || echo '')"

if [[ "$NEW_VERSION" == "$CUR_VERSION" ]]; then
  echo "Error: Provided version is the same as the current version ($CUR_VERSION)" >&2
  exit 1
fi

# Update VERSION file
echo "$NEW_VERSION" > VERSION

# Prepend to CHANGELOG.md
if [[ -f CHANGELOG.md ]]; then
  printf "## %s\n- _Describe your changes here._\n\n" "$NEW_VERSION" | cat - CHANGELOG.md > .CHANGELOG.tmp && mv .CHANGELOG.tmp CHANGELOG.md
else
  printf "## %s\n- _Describe your changes here._\n\n" "$NEW_VERSION" > CHANGELOG.md
fi

git add VERSION CHANGELOG.md
git commit -m "chore: bump version to $NEW_VERSION"
git tag "$NEW_VERSION" -m "Release $NEW_VERSION"

# Move/update 'latest' tag
if git rev-parse latest >/dev/null 2>&1; then
  git tag -d latest
  git push origin :refs/tags/latest || true
fi
git tag latest -f -m "Alias for latest release"
git push origin "$NEW_VERSION"
git push origin latest -f

echo "Version updated to $NEW_VERSION, 'latest' tag moved. Push complete."