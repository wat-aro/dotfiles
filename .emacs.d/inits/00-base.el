;;; GC
(setq-default gc-cons-percentage 0.5)

;; PATH
;; fish

;; (let ((path-from-shell (shell-command-to-string "/usr/local/bin/fish -i -c \"echo -n \\$PATH[1]; for val in \\$PATH[2..-1];echo -n \\\":\\$val\\\";end\"")))
;;   (setenv "PATH" path-from-shell)
;;   (setq exec-path (split-string path-from-shell ":")))

; zsh
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))

(let ((default-directory (locate-user-emacs-file "./elisp")))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))
;; (let ((opam-directory "~/.opam/system/share/emacs/site-lisp")
;;       (rbenv-directory "~/.rbenv/shims")
;;       (local-path "~/.local/bin"))
;;   (add-to-list 'exec-path opam-directory)
;;   (add-to-list 'exec-path rbenv-directory)
;;   (add-to-list 'exec-path local-path))

;;; Language
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")
