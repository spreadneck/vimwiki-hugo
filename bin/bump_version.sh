#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <MAJOR.MINOR.PATCH.YYYY.MM.DD-V>"
  exit 1
fi

VERSION="$1"

# Update version file
printf "%s" "$VERSION" > VERSION

git add VERSION

git commit -m "bump version to $VERSION" && git tag "$VERSION"
