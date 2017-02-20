#!/bin/bash

prettyInstall() {
  echo -e " \x1b[0;32m• Installing\x1b[m $1"
}
prettySkip() {
  echo -e " \x1b[0;33m× Skipping\x1b[m $1"
}
prettyDetail() {
  echo -e "   $1"
}

INSTALL_ITEMS=() # Set INSTALL_ITEMS before calling maybeInstall
maybeInstall() {
  local all=$(printf " %s" "${INSTALL_ITEMS[@]}")
  all=${all:1:${#all}} # Remove leading whitespace
  local title=$1
  local typ=$2
  local typPl=$(printf "%ss" $typ)
  local installCmd=$3

  printf "\n$title\nInstall $typPl $all? [yN] "
  read installAll

  if [ "$installAll" == "y" ]; then
    prettyInstall "$typPl $all"
    prettyDetail "$installCmd $all"
    $installCmd $all
  else
    for item in "${INSTALL_ITEMS[@]}"
    do
      printf "\nInstall $typ $item? [yN] "
      read installSingle

      if [ "$installSingle" == "y" ]; then
        prettyInstall "$typPl $item"
        prettyDetail "$installCmd $item"
        $installCmd $item
      else
        prettySkip "$typ $item"
      fi
    done
  fi
}

# 
# Homebrew: https://brew.sh/
#
printf "Install Homebrew? [yN] "
read installHomebrew

if [ "$installHomebrew" == "y" ]; then
  prettyInstall "Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  prettySkip "Homebrew"
fi

#
# Homebrew casks
#
INSTALL_ITEMS=(google-chrome iterm2 spotify slack)
maybeInstall "Must have casks" "cask" "brew cask install"

#
# Homebrew kegs
#
INSTALL_ITEMS=(git macvim the_silver_searcher thefuck)
maybeInstall "Must have kegs" "keg" "brew install"

INSTALL_ITEMS=(seil hammerspoon sublime-text firefox sketch)
maybeInstall "Extra casks" "cask" "brew cask install"

INSTALL_ITEMS=(erlang elixir heroku)
maybeInstall "Extra kegs" "keg" "brew install"

#
# prezto setup
# https://github.com/pettereek/prezto
#
preztoUrl="https://github.com/pettereek/prezto"

printf "\nInstall prezto? [yN] "
read installZsh

if [ "$installZsh" == "y" ]; then
  prettyInstall "prezto"
  prettyDetail "Opened $preztoUrl"
  $BROWSER $preztoUrl
else
  prettySkip "prezto"
fi

#
# Linking dotfiles
#
printf "\nLink dotfiles? [yN] "
read linkDotfiles

if [ "$linkDotfiles" == "y" ]; then
  prettyInstall "dotfiles"
  dotfiles=(gitconfig gvimrc vimrc hammerspoon)
  for dotfile in ${dotfiles[@]}
  do
    prettyDetail "ln -s $(pwd)/$dotfile $(echo $HOME)/.$dotfile"
    ln -s $(pwd)/$dotfile $(echo $HOME)/.$dotfile
  done
else
  prettySkip "dotfiles"
fi

#
# Vim plugins
#
printf "\nInstall Vim plugins? [yN] "
read installVimPlugins

if [ "$installVimPlugins" == "y" ]; then
  prettyInstall "Vim plugins"
  prettyDetail "vim +PluginInstall +qall"
  vim +PluginInstall +qall
else
  prettySkip "Vim plugins"
fi

printf "\nDone!"
