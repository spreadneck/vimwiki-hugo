.PHONY: build serve stow

build:
@hugo --minify --themesDir themes

serve:
@hugo server --minify --themesDir themes

stow:
@cd dotfiles && stow nvim
