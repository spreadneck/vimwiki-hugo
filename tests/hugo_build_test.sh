#!/usr/bin/env bash
set -euo pipefail

hugo --minify --baseURL http://example.com

if [ ! -d public ] || [ -z "$(ls -A public)" ]; then
  echo "Build failed: public directory is empty" >&2
  exit 1
fi

# Ensure at least one HTML or XML file generated
if ! find public -name '*.html' -o -name '*.xml' | grep -q .; then
  echo "Build failed: no HTML/XML output" >&2
  exit 1
fi

rm -rf public
