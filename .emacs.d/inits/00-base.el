;;; GC
(setq-default gc-cons-percentage 0.5)

;; PATH
;; fish
(let ((path-from-shell (shell-command-to-string "/usr/local/bin/fish -i -c \"echo -n \\$PATH[1]; for val in \\$PATH[2..-1];echo -n \\\":\\$val\\\";end\"")))
  (setenv "PATH" path-from-shell)
  (setq exec-path (split-string path-from-shell ":")))
;; zsh
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))

(let ((default-directory (locate-user-emacs-file "./elisp"))
      (opam-directory "~/.opam/system/share/emacs/site-lisp"))
  (add-to-list 'load-path default-directory)
  (add-to-list 'load-path opam-directory)
  (normal-top-level-add-subdirs-to-load-path))

;;; Language
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")
