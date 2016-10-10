#!/bin/sh
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew update
brew upgrade

brew tap caskroom/cask
brew tap homebrew/dupes
brew tap sanemat/font
brew tap snmsts/roswell

brew install aspcud
brew install autoconf
brew install automake
brew install boost
brew install cairo
brew install camlp4
brew install cask
brew install chromedriver
brew install clasp
brew install cmake
brew install cmigemo
brew install ctags
brew install czmq
brew install erlang
brew install elixir-build
brew install exenv
brew install fontconfig
brew install fontforge
brew install freetype
brew install gdbm
brew install gettext
brew install git
brew install glib
brew install global
brew install gmp
brew install gnutls
brew install go
brew install gobject-introspection
brew install gringo
brew install harfbuzz
brew install highlight
brew install hub
brew install icu4c
brew install imagemagick
brew install jpeg
brew install libevent
brew install libffi
brew install libpng
brew install libsodium
brew install libtasn1
brew install libtiff
brew install libtool
brew install lua
brew install mercurial
brew install mysql
brew install neovim
brew install nettle
brew install nkf
brew install ocaml
brew install ocamlbuild
brew install opam
brew install openssl
brew install pango
brew install pcre
brew install phantomjs
brew install pixman
brew install pkg-config
brew install postgresql
brew install python
brew install python3
brew install qt
brew install rbenv
brew install readline
brew install ricty
brew install roswell
brew install ruby-build
brew install sqlite
brew install terminal-notifier
brew install the_silver_searcher
brew install tmux
brew install wget
brew install wxmac
brew install xz
brew install zeromq
brew install --without-etcdir zsh
brew install brew install zsh-completions

brew cask install iterm2 %% brew cask cleanup
