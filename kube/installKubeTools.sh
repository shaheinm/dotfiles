#!/bin/bash

mkdir -p ~/.oh-my-zsh/completions
chmod -R 755 ~/.oh-my-zsh/completions

ln -s $DOTFILES/kube/kubectx/completion/kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh
ln -s $DOTFILES/kube/kubectx/completion/kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh

ln -s $DOTFILES/kube/kubectx/kubectx /usr/local/bin/kubectx
ln -s $DOTFILES/kube/kubectx/kubens /usr/local/bin/kubens

