# dotfiles

## Initialization

The repository must first be cloned on a newly installed system.

```bash
git clone git@github.com:olivervogel/dotfiles.git ~/.dotfiles
```

The script to initialize the configuration directories can then be invoked.

```bash
cd ~/.dotfiles && make install
```

Install [Homebrew](https://brew.sh/) and continue as follows.

```bash
brew bundle install
```

## Tools

- [kitty](https://sw.kovidgoyal.net/kitty)
    - [zsh](https://www.zsh.org)
        - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
        - [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
    - [neovim](https://www.neovim.io)
        - [lazy.nvim](https://github.com/folke/lazy.nvim)
            - [Comment.nvim](https://github.com/numToStr/Comment.nvim)
            - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
            - [Vim Tmux Navigator](https://github.com/christoomey/vim-tmux-navigator)
            - [Wansmer/treesj](https://github.com/Wansmer/treesj)
            - [blink.cmp](https://github.com/saghen/blink.cmp)
            - [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
            - [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
            - [lspconfig](https://github.com/neovim/nvim-lspconfig)
            - [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) (customized)
            - [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
            - [nvim-lint](https://github.com/mfussenegger/nvim-lint)
            - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
            - [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
            - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
            - [tpope/vim-ragtag](https://github.com/tpope/vim-ragtag)
    - [Intervention Pinboard](https://github.com/Intervention/pinboard)
    - [Timewarrior](https://github.com/GothenburgBitFactory/timewarrior)
    - [age-plugin-yubikey](https://github.com/str4d/age-plugin-yubikey)
    - [age](https://github.com/FiloSottile/age)
    - [bat](https://github.com/sharkdp/bat)
    - [delta](https://github.com/dandavison/delta)
    - [espanso](https://github.com/espanso/espanso)
    - [eza](https://github.com/eza-community/eza/)
    - [fzf](https://github.com/junegunn/fzf)
    - [jq](https://jqlang.github.io/jq/)
    - [oath-toolkit](https://www.nongnu.org/oath-toolkit/)
    - [passage](https://github.com/FiloSottile/passage)
        - [gnu-getopt](https://formulae.brew.sh/formula/gnu-getopt)
        - [libqrencode](https://github.com/fukuchi/libqrencode)
        - [tree](https://github.com/Old-Man-Programmer/tree)
    - [renameutils](https://www.nongnu.org/renameutils/)
    - [restic](https://github.com/restic/restic)
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - [skhd](https://github.com/koekeishiya/skhd)
    - [tmux](https://github.com/tmux/tmux)
    - [ykman](https://developers.yubico.com/yubikey-manager/)
    - [z - jump around](https://github.com/rupa/z)

## Fonts

- [JetBrains Mono](https://www.jetbrains.com/mono/)
- [Symbols-2048-em Nerd Font Complete Mono](https://github.com/ryanoasis/nerd-fonts)

## Language Servers

- [intelephense](https://github.com/bmewburn/vscode-intelephense)
- [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted)

## Keyboard Layout

Depending on the region, it is possible that keyboards have so-called dead
keys. For software developers, this can lead to undesired input behavior.
Especially the keyboards with ISO-DE layout have annoying dead keys which
unnecessarily negatively affect the workflow in Neovim.

This custom keyboard layout bundle for macOS removes the dead key behaviour.
Put `macos/No Dead Keys.bundle` into `/Library/Keyboard Layouts/` and load and
apply it via System Preferences afterwards.
