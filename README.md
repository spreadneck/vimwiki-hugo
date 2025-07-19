# My Wiki & Blog

[![GitHub release](<<<<<https://img.shields.io/github/release/spreadneck/vimwiki-hugo.svg)](https://github.com/spreadneck/vimwiki-hugo/releases/latest)>>>>>
[![CI Status](<<<<<https://github.com/spreadneck/vimwiki-hugo/actions/workflows/ci.yml/badge.svg)](https://github.com/spreadneck/vimwiki-hugo/actions)>>>>>
[![MIT License](<<<<<https://img.shields.io/badge/license-MIT-blue)](LICENSE)>>>>>
[![Hugo](<<<<<https://img.shields.io/badge/built%20with-hugo-ff4088?logo=hugo)](https://gohugo.io/)>>>>>

A personal knowledge base, blog, and developer log powered by [Hugo Book](<<<<<https://github.com/alex-shpak/hugo-book)>>>>> with seamless Vimwiki and Neovim integration.

---

## 🚀 Feature Highlights

- **Lightning fast Hugo Book site**: Easy to read, clean, mobile-ready
- **Markdown-based wiki & posts**: Simple, local-first, no lock-in
- **Vimwiki-native**: Manage notes in Vimwiki, publish with Hugo
- **Dotfiles with GNU Stow**: Simple config management for Neovim & Vimwiki
- **Offline support, dark/light mode, instant search**
- **Automated CI**: Shell script linting, Hugo build checks

---

## 🗺️ Project Plan

- [x] Hugo Book theming & config (`hugo.yaml`)
- [x] Neovim dotfile management with Stow
- [x] Makefile for common tasks (`build`, `serve`, `stow`)
- [x] GitHub Actions for CI, ShellCheck, build testing
- [x] Versioning, release notes, and CHANGELOG
- [ ] More developer docs & templates
- [ ] Optional: Deployment via GitHub Pages or Netlify
- [ ] More automated tests
- [ ] Contribution guide & setup scripts

---

## 🖥️ Quickstart

### 1. Prerequisites

- [Hugo Extended](<<<<<https://gohugo.io/getting-started/installing/)>>>>> `0.134+`
- [git](<<<<<https://git-scm.com/)>>>>> (with submodule support)
- [GNU Stow](<<<<<https://www.gnu.org/software/stow/)>>>>>
- [Neovim](<<<<<https://neovim.io/)>>>>> with [Vimwiki](<<<<<https://github.com/vimwiki/vimwiki)>>>>>

### 2. Install & Set Up

```sh
git clone --recurse-submodules <<<<<https://github.com/spreadneck/vimwiki-hugo.git>>>>>
cd vimwiki-hugo
cd dotfiles && stow nvim
```

### 3. Author & Publish Notes

- Use Neovim + Vimwiki for all note editing
- Symlink or move finished notes into `content/docs/` or `content/posts/`
- Customize using `hugo.yaml` and your `.config/nvim/`

### 4. Preview Locally

```sh
hugo server --minify --themesDir themes
# ⇒ <<<<<http://localhost:1313>>>>>
```

### 5. Build Static Site

```sh
make build
# Output in ./public
```

---

## 🤖 Automation

- **CI Build:** All PRs and pushes to main run Hugo build and ShellCheck (`.github/workflows/ci.yml`)
- **ShellCheck:** Lints all Bash scripts in `bin/` on any change

---

## 📚 Structure

## 📚 Documentation & Community

- [Changelog](./CHANGELOG.md) — See what's new in each release
- [Contributing Guide](./CONTRIBUTING.md) — How to contribute code, docs, or report bugs
- [Release Checklist](./RELEASE_CHECKLIST.md) — Maintainer checklist for new versions

## Local Pre-commit Hooks

We use [pre-commit](<<<<<https://pre-commit.com/)>>>>> to auto-check Markdown and YAML code style before each commit.

**Setup once:**

```sh
pip install pre-commit
pre-commit install
```

**Run manually (all files):**

```sh
pre-commit run --all-files
```
