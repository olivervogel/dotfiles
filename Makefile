install:
		@DOTFILES_PATH=$$(pwd); echo $$DOTFILES_PATH
		@mkdir -p ~/.config
		@ln -nfs $$(pwd)/zsh ~/.config/zsh
		@ln -nfs $$(pwd)/p10k ~/.config/p10k
		@ln -nfs $$(pwd)/tmux ~/.config/tmux
		@ln -nfs $$(pwd)/nvim ~/.config/nvim
		@ln -nfs $$(pwd)/git ~/.config/git
		@ln -nfs $$(pwd)/kitty ~/.config/kitty
		@ln -nfs $$(pwd)/skhd ~/.config/skhd
		@ln -nfs $$(pwd)/restic ~/.config/restic
		@ln -nfs $$(pwd)/timewarrior ~/.config/timewarrior
		@ln -nfs $$(pwd)/rc/zshrc ~/.zshrc
		@ln -nfs $$(pwd)/rc/p10k.zsh ~/.p10k.zsh
		@ln -nfs $$(pwd)/rc/tmux.conf ~/.tmux.conf
		@touch ~/.hushlogin
		@defaults write -g NSWindowShouldDragOnGesture -bool true
		@echo "Installation successfully completed"
