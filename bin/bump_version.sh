#!/usr/bin/env bash

# bump_version.sh -- Bump version using MAJOR.MINOR.YYYY.MM.DD.PATCH scheme.
#
# Usage:
#   bin/bump_version.sh <MAJOR.MINOR>
#
# Example:
#   bin/bump_version.sh 0.0
#

set -euo pipefail

RED='\033[31m'; GREEN='\033[32m'; YELLOW='\033[33m'; CYAN='\033[36m'; NC='\033[0m'

usage() {
  echo -e "${CYAN}Usage:${NC} $0 <MAJOR.MINOR>"
  echo "  Example: $0 0.0"
  exit 1
}

if [[ "$#" -ne 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
  usage
fi

MAJOR_MINOR="$1"

TODAY=$(date +%Y.%m.%d)

if [[ ! -f VERSION ]]; then
  echo -e "${RED}ERROR:${NC} VERSION file missing." >&2
  exit 2
fi

LAST_VERSION=$(cat VERSION | tr -d '[:space:]')
RE="^([0-9]+)\.([0-9]+)\.([0-9]{4})\.([0-9]{2})\.([0-9]{2})\.([0-9]+)$"

PATCH=1

if [[ $LAST_VERSION =~ $RE ]]; then
  LAST_MM="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
  LAST_DATE="${BASH_REMATCH[3]}.${BASH_REMATCH[4]}.${BASH_REMATCH[5]}"
  LAST_PATCH="${BASH_REMATCH[6]}"
  if [[ "$LAST_MM" == "$MAJOR_MINOR" && "$LAST_DATE" == "$TODAY" ]]; then
    PATCH=$(( LAST_PATCH + 1 ))
  fi
fi

NEW_VERSION="${MAJOR_MINOR}.${TODAY}.${PATCH}"

echo "$NEW_VERSION" > VERSION
echo -e "${GREEN}VERSION file updated: $NEW_VERSION${NC}"

if [ -f CHANGELOG.md ]; then
  if ! grep -q "$NEW_VERSION" CHANGELOG.md; then
    sed -i "1i\\
## $NEW_VERSION\\
- _Describe your changes here._\\
" CHANGELOG.md
    echo -e "${GREEN}New section prepended to CHANGELOG.md${NC}"
  fi
fi

git add VERSION
[ -f CHANGELOG.md ] && git add CHANGELOG.md
git commit -m "chore: bump version to $NEW_VERSION"

if git rev-parse "$NEW_VERSION" >/dev/null 2>&1; then
  echo -e "${YELLOW}Warning:${NC} Git tag $NEW_VERSION already exists. Not retagging."
else
  git tag "$NEW_VERSION"
  echo -e "${GREEN}Git tag created: $NEW_VERSION${NC}"
fi

echo -e "${CYAN}Done. Push your changes using:${NC}"
echo "  git push && git push --tags"