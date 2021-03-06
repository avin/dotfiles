zsh-syntax-highlighting / highlighters / main
=============================================

This is the ***main*** highlighter, that highlights:

* Commands
* Options
* Arguments
* Paths
* Strings

How to activate it
------------------
To activate it, add it to `ZSH_HIGHLIGHT_HIGHLIGHTERS`:

    ZSH_HIGHLIGHT_HIGHLIGHTERS=( [...] main)

This highlighter is active by default.


How to tweak it
---------------
This highlighter defines the following styles:

* `unknown-token` - unknown tokens / errors
* `reserved-word` - shell reserved words
* `alias` - aliases
* `suffix-alias` - suffix aliases (requires zsh 5.1.1 or newer)
* `builtin` - shell builtin commands
* `function` - functions
* `command` - commands
* `precommand` - precommands (i.e. exec, builtin, ...)
* `commandseparator` - command separation tokens
* `hashed-command` - hashed commands
* `path` - paths
* `path_prefix` - path prefixes
* `path_approx` - approximated paths
* `globbing` - globbing expressions (`*.txt`)
* `history-expansion` - history expansion expressions (`!foo` and `^foo^bar`)
* `single-hyphen-option` - single hyphen options (-o)
* `double-hyphen-option` - double hyphen options (--option)
* `back-quoted-argument` - backquoted expressions (`` `foo` ``)
* `single-quoted-argument` - single quoted arguments (`` 'foo' ``)
* `double-quoted-argument` - double quoted arguments (`` "foo" ``)
* `dollar-quoted-argument` - dollar quoted arguments (`` $'foo' ``)
* `dollar-double-quoted-argument` -  dollar double quoted arguments ($foo inside "")
* `back-double-quoted-argument` -  back double quoted arguments (\x inside "")
* `back-dollar-quoted-argument` -  back dollar quoted arguments (\x inside $'')
* `assign` - variable assignments
* `redirection` - redirection operators (`<`, `>`, etc)
* `default` - parts of the buffer that do not match anything

To override one of those styles, change its entry in `ZSH_HIGHLIGHT_STYLES`, for example in `~/.zshrc`:

    # Declare the variable
    typeset -A ZSH_HIGHLIGHT_STYLES

    # To differentiate aliases from other command types
    ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
    
    # To have paths colored instead of underlined
    ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
    
    # To disable highlighting of globbing expressions
    ZSH_HIGHLIGHT_STYLES[globbing]='none'

The syntax for declaring styles is documented in [the `zshzle(1)` manual
page](http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#SEC135).
