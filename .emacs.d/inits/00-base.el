;;; GC
(setq gc-cons-threshold (* 128 1024 1024))
(setq-default gc-cons-percentage 0.5)

;; PATH
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(let ((default-directory (locate-user-emacs-file "elisp")))
  (add-to-list 'load-path default-directory)
  (add-to-list 'load-path (locate-user-emacs-file "elisp/gcal"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'exec-path "~/.local/bin")
(add-to-list 'exec-path "~/.cargo/bin")
(add-to-list 'exec-path "~/go/bin")

;;; Language
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")
(set-coding-system-priority 'utf-8)

(use-package bind-key)

(use-package mozc
  :init
  (setq default-input-method "japanese-mozc")
  :custom
  (mozc-candidate-style 'overlay)
  :bind
  ("C-\\" . toggle-input-method))
