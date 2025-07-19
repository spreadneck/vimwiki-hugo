.PHONY: build serve stow test lint deploy

# Build the Hugo site
build:
	@hugo --minify --themesDir themes

# Serve the Hugo site locally
serve:
	@hugo server --minify --themesDir themes

# Stow dotfiles
stow:
	@cd dotfiles && stow -t ~ nvim

# Run tests
test:
	@echo "Running tests..."
	@./tests/hugo_build_test.sh
	@echo "Running ShellCheck..."
	@shellcheck bin/*.sh
	@echo "Running Markdown linting..."
	@markdownlint-cli2 '**/*.md' '#node_modules'
	@echo "Running YAML linting..."
	@find . \( -path ./node_modules -o -path ./.git \) -prune -false -o \( -name '*.yaml' -o -name '*.yml' \) -print | xargs yamllint -c .yamllint
	@echo "Running Markdown link check..."
	@find . -name "*.md" | xargs -n 1 markdown-link-check -c .markdown-link-check.json
	@echo "Running htmltest on built site..."
	@htmltest --config .htmltest.yml ./public

# Run linters
lint:
	@echo "Running ShellCheck..."
	@shellcheck bin/*.sh
	@echo "Running Markdown linting..."
	@markdownlint-cli2 '**/*.md' '#node_modules'
	@echo "Running YAML linting..."
	@find . \( -path ./node_modules -o -path ./.git \) -prune -false -o \( -name '*.yaml' -o -name '*.yml' \) -print | xargs yamllint -c .yamllint
	@echo "Running Markdown link check..."
	@find . -name "*.md" | xargs -n 1 markdown-link-check -c .markdown-link-check.json

# Deploy the site to GitHub Pages
deploy:
	@echo "Deploying to GitHub Pages..."
	@hugo --minify --themesDir themes --baseURL="https://USERNAME.github.io/REPOSITORY/"
	@git add public
	@git commit -m "Deploy to GitHub Pages"
	@git push origin `git subtree split --prefix public main`:gh-pages --force

# Run GitHub Actions tests
github-actions:
	@echo "Running GitHub Actions tests..."
	@gh workflow run ci.yml
	@gh workflow run release.yml