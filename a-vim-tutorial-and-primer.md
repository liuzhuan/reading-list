# A vim Tutorial and Primer

https://danielmiessler.com/study/vim/

by Daniel Miessler

The goal of this tutorial is to take you through every stage of progression - from understanding the vim philosophy(which will stay with you forever), to surpassing your skill with your current editor, to becoming "one of those people".

## A few key `~/.vimrc` changes

```
inoremap jk <ESC>

# Changing the leader key
let mapleader = "\<Space>"

# Remapping CAPSLOCK to Ctrl at operating system level

filetype plugin indent on
set encoding=utf-8
```

## Vim as language

Arguably the most brilliant thing about vim is that as you use it you begin to think in it. Vim is set up to function like a language, complete with nouns, verbs, and adverbs.
