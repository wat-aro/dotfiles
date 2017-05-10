;;; GC
(setq-default gc-cons-percentage 0.5)

;; PATH
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(let ((default-directory (locate-user-emacs-file "./elisp")))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(let ((opam-directory "~/.opam/system/share/emacs/site-lisp")
      (rbenv-directory "~/.rbenv/shims"))
  (add-to-list 'load-path opam-directory)
  (add-to-list 'load-path rbenv-directory))

;;; Language
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")
