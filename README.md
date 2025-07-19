# My Wiki & Blog

A personal knowledge base, blog, and developer log powered by [Hugo Book](https://github.com/alex-shpak/hugo-book) and integrated with Vimwiki and Neovim for rapid note-taking and publishing.

## Features

- Clean, fast, and mobile-friendly documentation & blog using [Hugo Book](https://github.com/alex-shpak/hugo-book)
- Markdown-based wiki and personal blogging with simple directory structure
- Native [Vimwiki](https://github.com/vimwiki/vimwiki) support for editing and managing notes locally
- Neovim configuration stored as a dotfile and managed with [GNU Stow](https://www.gnu.org/software/stow/) for simple symlink management
- Seamless workflow from writing in Vimwiki to publishing in Hugo
- Offline support, automated Table of Contents, dark/light mode, and integrated search

## Workflow Summary

1. **Edit Notes Locally**:  
   Use [Neovim](https://neovim.io/) and [Vimwiki](https://github.com/vimwiki/vimwiki) to create or edit Markdown notes.
2. **Organize with Vimwiki**:  
   Use Vimwiki's commands (e.g., `<Leader>ww`, `<Leader>wd`, etc.) to create entries in your local wiki.
3. **Symlink configs with Stow**:
   ```sh
   cd dotfiles
   stow nvim
   ```
   This applies the Neovim/Vimwiki configuration system-wide.
4. **Sync with Hugo**:  
   Use, move, or symlink your Vimwiki `.md` files into your Hugo `content/` folders (e.g. `content/posts/`, `content/docs/`).
5. **Publish**:  
   Use Hugo to build and serve your blog/wiki for the web.

## Project Structure

```
.
├── content/
│   ├── _index.md           # Wiki/docs home
│   └── posts/
│       ├── _index.md       # Blog index
│       └── <date>.md       # Daily notes/posts (from Vimwiki)
├── dotfiles/
│   └── nvim/
│       └── .config/nvim/init.lua  # Neovim config with Vimwiki
├── themes/
│   └── hugo-book/          # Hugo Book theme (submodule)
├── hugo.yaml
└── .gitmodules             # Theme submodule reference
```

## Getting Started

### Prerequisites

- [Hugo Extended](https://gohugo.io/getting-started/installing/) `0.134` or newer
- [git](https://git-scm.com/)
- [GNU Stow](https://www.gnu.org/software/stow/)
- [Neovim](https://neovim.io/) with [Vimwiki](https://github.com/vimwiki/vimwiki) installed

### Clone the Repo

```sh
git clone --recurse-submodules <your-repo-url>
cd <your-repo-name>
```

If submodules weren't cloned:
```sh
git submodule update --init --recursive
```

### Apply Neovim Config

```sh
cd dotfiles
stow nvim
```

This symlinks your `.config/nvim` directory into your home directory.

### Edit and Sync Content

- Use `nvim` with Vimwiki to make notes in your `vimwiki` directory.
- Move or symlink completed wiki and blog entries into `content/docs/` or `content/posts/` for publishing.

### Preview Site

```sh
hugo server --minify --themesDir themes
```
Available at http://localhost:1313

## Versioning

This project uses a date-stamped version scheme:

```
MAJOR.MINOR.YYYY.MM.DD.PATCH
```

- `MAJOR` and `MINOR` follow [semantic versioning](https://semver.org/). `0.0` denotes a pre-release.
- `YYYY.MM.DD` is the release date.
- `PATCH` increments for additional releases on the same day.

Example: `0.0.2025.07.18.1`.

Tags in git match this string.

Use `bin/bump_version.sh <version>` to update the `VERSION` file and tag the commit.

## Customization

- Tune Hugo in [`hugo.yaml`](./hugo.yaml)
- Edit or expand Neovim config in `dotfiles/nvim/.config/nvim/`
- Add assets, styles, or change themes by modifying Hugo configs or the theme submodule

## License

MIT for your work.  
Hugo Book theme is under [MIT](themes/hugo-book/LICENSE).

---

## Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Hugo Book Theme](https://github.com/alex-shpak/hugo-book/)
- [Vimwiki](https://github.com/vimwiki/vimwiki)
- [GNU Stow](https://www.gnu.org/software/stow/)
