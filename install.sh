#!/bin/bash

if [ -d "$HOME/.dotfiles" ]; then
  echo "Dotfiles already present."
  exit -1
fi

echo "installing collaboratory dotfiles"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  PLATFORM="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="mac"
else
  PLATFORM="unsupported"
fi
echo "platform: $PLATFORM"

fn_exists() { 
  type $1 &> /dev/null && echo 1 || echo 0
}

HAS_ZSH=$(fn_exists zsh)
HAS_VOLTA=$(fn_exists volta)

echo "Has ZSH: $HAS_ZSH"

echo "================================="
echo "updating & installing packages"
if [ -n $ZSH_VERSION ]; then
  echo "zsh detected"
else
  if [ PLATFORM == "linux" ]; then
    sudo apt update
    sudo apt install -y git build-essential curl wget zsh
    sudo apt remove -y nodejs
    sudo apt upgrade -y
    sudo apt dist-upgrade -y
    sudo apt autoremove -y
  elif [ PLATFORM == "mac" ]; then
    brew update
    brew upgrade
    brew doctor
    brew cleanup
    brew uninstall nodejs
    brew install zsh curl
  fi

  zsh
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh detected"
else
  echo "installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  source ~/.zshrc
fi

if [ $(fn_exists volta) == 1 ]; then
  echo "volta detected"
  volta install node
  volta install yarn
else
  echo "installing volta"
  curl https://get.volta.sh | bash
  source ~/.zshrc
  echo "installing node & yarn in volta"
  volta install node
  volta install yarn
fi

if [ $(fn_exists nvim) ]; then
  echo "neovim detected"
else
  echo "installing neovim"
  if [ PLATFORM == "linux" ]; then
    sudo apt install -y neovim
  elif [PLATFORM == "mac" ]; then
    brew install --HEAD neovim
  fi
fi

if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
  echo "vim-plug detected"
else
  echo "installing vim-plug"
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ -f "$HOME"/.config/nvim/init.vim ]; then
  echo "~/.config/nvim/init.vim already exists; renaming to ~/.config/nvim/init.vim.$EPOCHSECONDS"
  mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.$EPOCHSECONDS
fi

echo "copying init.vim"
curl -fLo ~/.config/nvim/init.vim --create-dirs \
  https://raw.githubusercontent.com/collaboratory/dotfiles/main/init.vim
