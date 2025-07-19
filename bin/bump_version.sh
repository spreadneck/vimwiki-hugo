#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <MAJOR.MINOR> [-m 'Release notes']" >&2
  exit 1
}

if [[ $# -lt 1 ]]; then
  usage
fi

MAJOR_MINOR=
RELEASE_NOTES=

while [[ $# -gt 0 ]]; do
  case "$1" in
    -m|--message)
      shift
      RELEASE_NOTES="$1"
      ;;
    [0-9]*.[0-9]*)
      MAJOR_MINOR="$1"
      ;;
    *)
      usage
      ;;
  esac
  shift
done

[[ "$MAJOR_MINOR" =~ ^[0-9]+\.[0-9]+$ ]] || usage

DATE="$(date +'%Y.%m.%d')"
MATCH_RE="^## $MAJOR_MINOR\\.$DATE\\."
PATCH=1

if [[ -f CHANGELOG.md ]]; then
  LAST_PATCH=$(grep -E "${MATCH_RE}[0-9]+\$" CHANGELOG.md \
    | sed -E "s/${MATCH_RE}//" | sort -nr | head -1 || echo "")
  if [[ -n "$LAST_PATCH" ]]; then
    PATCH=$((LAST_PATCH + 1))
  fi
fi

NEW_VERSION="$MAJOR_MINOR.$DATE.$PATCH"
CUR_VERSION=$(cat VERSION 2>/dev/null || echo "")

if [[ "$NEW_VERSION" == "$CUR_VERSION" ]]; then
  echo "Error: Already at version $CUR_VERSION" >&2
  exit 1
fi

if [[ -z "${RELEASE_NOTES:-}" ]]; then
  echo "Enter release notes. Finish with an empty line:"
  NOTES=""
  while IFS= read -r line; do
    [[ -z "$line" ]] && break
    NOTES="${NOTES}- $line"$'\n'
  done
  RELEASE_NOTES="${NOTES:-"- _Describe your changes here._\n"}"
fi

# Update version file
echo "$NEW_VERSION" > VERSION

# Prepend to CHANGELOG
printf "## %s\n%s\n" "$NEW_VERSION" "${RELEASE_NOTES}" | cat - CHANGELOG.md > .CHANGELOG.tmp && mv .CHANGELOG.tmp CHANGELOG.md

git add VERSION CHANGELOG.md
git commit -m "chore: bump version to $NEW_VERSION"
git tag "$NEW_VERSION" -m "Release $NEW_VERSION"

if git rev-parse latest >/dev/null 2>&1; then
  git tag -d latest
  git push origin :refs/tags/latest || true
fi
git tag latest -f -m "Alias for latest release"
git push origin "$NEW_VERSION"
git push origin latest -f

echo "Version bumped to $NEW_VERSION and 'latest' tag updated."