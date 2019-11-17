;;; GC
(setq-default gc-cons-percentage 0.5)

;; PATH
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(let ((default-directory (locate-user-emacs-file "./elisp")))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(let ((local-bin "~/.local/bin"))
  (add-to-list 'load-path local-bin)
  (add-to-list 'exec-path local-bin))

;;; Language
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")

(require 'uim)
(uim-mode)
