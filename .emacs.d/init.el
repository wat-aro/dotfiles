(package-initialize)

(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)

(use-package pallet
  :init
  (pallet-mode t))

(use-package init-loader
  :init
  (init-loader-load "~/.emacs.d/inits"))

(server-start)
