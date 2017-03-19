# A vim Tutorial and Primer

https://danielmiessler.com/study/vim/

By Daniel Miessler

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

```
d2w # Delete two words
cis # Change inside sentence
yip # Yank inside paragraph
ct< # Change to open bracket
```

## A search reference

* `/{string}`: search for string
* `t`: jump up to a character
* `f`: jump onto a character
* `*`: search for other instances of the word under your cursor
* `n`: go to the next instance
* `N`: go to the previous instance
* `;`: go to the next instance when you've jumped to a character
* `,`: go to the previous instance when you've jumped to a character

## Moving Around In Your Text

* `w`: move forward one word
* `b`: move back one word
* `e`: move to the end of your word
* `W`: move forward one big word
* `B`: move back one big word
* `)`: move forward one sentence
* `}`: move forward one paragraph
* `H`: move to the top of the screen
* `M`: move to the middle of the screen
* `L`: move to the bottom of the screen
* `gg`: go to the top of the file
* `G`: go to the bottom of the file
* `^U`: move up half a screen. `^` - <Ctrl>
* `^D`: move down half a screen
* `^F`: page down
* `^B`: page up

While you're in normal mode it's possible to jump back and forth between two places, which can be extremely handy.

* `Ctrl-i`: jump to your previous navigation location
* `Ctrl-o`: jump back to where you were
* `:line_number`: move to a given line number
* `^E`: scroll up one line
* `^Y`: scroll down one line

## Changing Text

### Understanding modes

`Insert Mode` <==> `Command Mode` <==> `Visual Mode`

`Normal Mode` is also known as `Command Mode`.

The purpose of Visual Mode is to then perform some operation on all the content you have highlighted, which makes it very powerful.

`Ex Mode` is a mode where you drop down to the bottom, where you get a ":" prompt, and you can enter commands.

* `C`: Delete the line from where you're at, and enter insert mode
* `S`: Delete the entire line you're on, and enter insert mode
* `~`: Changing case

### Formatting Text

* `gq ap`: Format the current paragraph

`gq` works based on your textwidth setting. `ap` piece is the standard "around paragraph" text object.

### Basic deletion options

* `D`: delete to the end of the line
* `J`: join the current line with the next one

### Undo and Redo

* `u`: undo your last action
* `Ctrl-r`: redo the last action

### Copy and Paste

* `y`: yank (copy) whatever is selected
* `yy`: yank the current line

### Switching lines of text

`ddp`

This is a quick trick you can use to swap the position of two lines of
text.

### Spell checking

```
# Somewhere in your `~/.vimrc`
set spell spelllang=en_us
```

You can enable or disable this by running `:set spell` and `:set nospell`

* `]s`: Go to the next misspelled word
* `[s`: Go to the last misspelled word
* `z=`: When on a misspelled word, get some suggestions
* `zg`: Mark a misspelled word as correct
* `zw` Mark a good word as misspelled

## Substitution

```
:%s /foo/bar/g # Change "foo" to "bar" on every line
:s /foo/bar/g # Change "foo" to "bar" on just the current line
```

## Making Things Repeatable
