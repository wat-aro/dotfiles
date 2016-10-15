;;; GC
(setq-default gc-cons-percentage 0.5)

;;; Language
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;; PATH
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(let ((default-directory (locate-user-emacs-file "./elisp"))
      (opam-directory "~/.opam/system/share/emacs/site-lisp"))
  (add-to-list 'load-path default-directory)
  (add-to-list 'load-path opam-directory)
  (normal-top-level-add-subdirs-to-load-path))

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")
