#!/usr/bin/env bash
set -euo pipefail

NOTES_FILE="$(mktemp)"
echo "- _Describe your changes here._" > "$NOTES_FILE"

"${EDITOR:-vi}" "$NOTES_FILE"
cat "$NOTES_FILE"
rm "$NOTES_FILE"#!/usr/bin/env bash
set -euo pipefail

NOTES_FILE="$(mktemp)"
echo "- _Describe your changes here._" > "$NOTES_FILE"

"${EDITOR:-vi}" "$NOTES_FILE"
cat "$NOTES_FILE"
rm "$NOTES_FILE"
