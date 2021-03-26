#!/bin/bash
source functions.sh

log "Installing @collaboratory/dotfiles"
log_info "Platform" $PLATFORM

HAS_ZSH=$(fn_exists zsh)
HAS_VOLTA=$(fn_exists volta)

if [ $PLATFORM == "linux" && $(fn_exists apt) == 0 ]; then
  log_error "Linux detected, but no apt. Cannot proceed." "This script only works for debian derivatives. Open a PR!"
elif [ $PLATFORM == "mac" && $(fn_exists brew) == 0 ]; then
  log_error "MacOS detected, but no brew. Cannot proceed." "This script only works with homebrew installed. Open a PR!"
fi

if [ ! -n $ZSH_VERSION ]; then
  log_info "installing zsh"
  if [ $PLATFORM == "linux" ]; then
    sudo apt update
    sudo apt install -y git build-essential curl wget zsh
    sudo apt remove -y nodejs
    sudo apt upgrade -y
    sudo apt dist-upgrade -y
    sudo apt autoremove -y
  elif [ $PLATFORM == "mac" ]; then
    log_info "installing zsh"
    brew update
    brew upgrade
    brew doctor
    brew cleanup
    brew uninstall nodejs
    brew install zsh curl
  fi

  log_info "starting zsh"
  zsh
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
  log_info "oh-my-zsh detected"
else
  log "installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  source ~/.zshrc
fi

if [ $(fn_exists volta) == 1 ]; then
  log_info "volta detected"
  volta install node
  volta install yarn
else
  log "installing volta"
  curl https://get.volta.sh | bash
  source ~/.zshrc
  log "installing node & yarn in volta"
  volta install node
  volta install yarn
fi

if [ $(fn_exists nvim) == 1 ]; then
  log_info "neovim detected"
else
  log "installing neovim"
  if [ $PLATFORM == "linux" ]; then
    sudo apt install -y neovim
  elif [ $PLATFORM == "mac" ]; then
    brew install --HEAD neovim
    pip3 install neovim
  fi
fi

if [ $(fn_exists python3) == 0 ]; then
  log "Installing python"
  if [ $PLATFORM == "linux" ]; then
    sudo apt install -y python3
  elif [ $PLATFORM == "mac" ]; then
    brew install python3
  fi
fi


if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
  log_info "vim-plug detected"
else
  log "installing vim-plug"
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ -f "$HOME"/.config/nvim/init.vim ]; then
  log_info "~/.config/nvim/init.vim already exists; renaming to ~/.config/nvim/init.vim.$EPOCHSECONDS"
  mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.$EPOCHSECONDS
fi

log "copying vim configuration"
curl -fLo ~/.config/nvim/init.vim --create-dirs \
  https://raw.githubusercontent.com/collaboratory/dotfiles/main/nvim/init.vim

log "starting vim to install plugins"
nvim +PlugInstall +UpdateRemotePlugins +qall

log "copying .zsh_profile"
curl -fLo ~/.zsh_profile \
  https://raw.githubusercontent.com/collaboratory/dotfiles/main/.zsh_profile

echo "source ~/.zsh_profile" >> ~/.zshrc

log_success "all set."
