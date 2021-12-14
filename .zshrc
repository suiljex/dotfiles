# [==================]
# | suiljex | .zshrc |
# [==================]

# Installation:
# curl -L git.io/antigen > antigen.zsh

source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Bundles from the custom repos.
antigen bundle endaaman/lxd-completion-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme risto

# Tell Antigen that you're done.
antigen apply

