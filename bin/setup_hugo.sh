#!/bin/bash
set -euo pipefail

# 1. Ensure hugo is installed
if ! command -v hugo &> /dev/null; then
    echo "Hugo is not installed. Please install Hugo first."
    exit 1
fi

# 2. Init site if not already in a Hugo repo
if [ ! -f config.toml ] && [ ! -f config.yaml ]; then
    hugo new site .
fi

# 3. Add hugo-book theme as submodule (recommended)
if [ ! -d themes/hugo-book ]; then
    git submodule add https://github.com/alex-shpak/hugo-book.git themes/hugo-book
fi

# 4. (Optional) Copy example config
if [ ! -f config.toml ]; then
    cp themes/hugo-book/exampleSite/config.toml .
fi

# 5. Notify user to adjust config/theme
echo "Be sure 'theme = \"hugo-book\"' is in your config.toml"

# 6. Build the site
hugo

echo "Site built! See ./public for output."
