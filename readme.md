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

## Tools

- [kitty](https://sw.kovidgoyal.net/kitty)
    - [zsh](https://www.zsh.org)
        - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
        - [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
    - [neovim](https://www.neovim.io)
        - [lazy.nvim](https://github.com/folke/lazy.nvim)
            - [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) (customized)
            - [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
            - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
            - [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
            - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
            - [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
            - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
            - [lspconfig](https://github.com/neovim/nvim-lspconfig)
            - [nvim-lint](https://github.com/mfussenegger/nvim-lint)
            - [Comment.nvim](https://github.com/numToStr/Comment.nvim)
            - [Wansmer/treesj](https://github.com/Wansmer/treesj)
            - [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
            - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp/)
            - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
            - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
            - [tpope/vim-ragtag](https://github.com/tpope/vim-ragtag)
            - [Vim Tmux Navigator](https://github.com/christoomey/vim-tmux-navigator)
    - [tmux](https://github.com/tmux/tmux)
    - [z - jump around](https://github.com/rupa/z)
    - [fzf](https://github.com/junegunn/fzf)
    - [eza](https://github.com/eza-community/eza/)
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - [renameutils](https://www.nongnu.org/renameutils/)
    - [delta](https://github.com/dandavison/delta)
    - [bat](https://github.com/sharkdp/bat)
    - [jq](https://jqlang.github.io/jq/)
    - [ykman](https://developers.yubico.com/yubikey-manager/)
    - [restic](https://github.com/restic/restic)
    - [age](https://github.com/FiloSottile/age)
    - [passage](https://github.com/FiloSottile/passage)
        - [gnu-getopt](https://formulae.brew.sh/formula/gnu-getopt)
        - [tree](https://github.com/Old-Man-Programmer/tree)
        - [libqrencode](https://github.com/fukuchi/libqrencode)
    - [age-plugin-yubikey](https://github.com/str4d/age-plugin-yubikey)
    - [oath-toolkit](https://www.nongnu.org/oath-toolkit/)
    - [zbar](https://github.com/mchehab/zbar)
    - [espanso](https://github.com/espanso/espanso)
    - [skhd](https://github.com/koekeishiya/skhd)
    - [Timewarrior](https://github.com/GothenburgBitFactory/timewarrior)
    - [Intervention Pinboard](https://github.com/Intervention/pinboard)

## Fonts

- [JetBrains Mono](https://www.jetbrains.com/mono/)
- [Symbols-2048-em Nerd Font Complete Mono](https://github.com/ryanoasis/nerd-fonts)

## Language Servers

- [intelephense](https://intelephense.com)
- [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted)

## Keyboard Layout

Depending on the region, it is possible that keyboards have so-called dead
keys. For software developers, this can lead to undesired input behavior.
Especially the keyboards with ISO-DE layout have annoying dead keys which
unnecessarily negatively affect the workflow in Neovim.

This custom keyboard layout bundle for macOS removes the dead key behaviour.
Put `macos/No Dead Keys.bundle` into `/Library/Keyboard Layouts/` and load and
apply it via System Preferences afterwards.
