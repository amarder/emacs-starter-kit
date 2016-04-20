For installation instructions, see the [Social Science Starter Kit page](http://kieranhealy.org/resources/emacs-starter-kit.html).

# Installation

I found installation of emacs using homebrew to be the easiest approach on Mac OS X.

	brew install emacs --cocoa
	brew link emacs

# Git

I'm working off of orgv8

https://help.github.com/articles/configuring-a-remote-for-a-fork/
https://help.github.com/articles/syncing-a-fork/

    git checkout amarder
    git fetch upstream
    git merge upstream/orgv8
