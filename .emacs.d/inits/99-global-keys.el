;; exchange meta-key to super-key
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier 'super)

;;; Key
;;(keyboard-translate ?\C-h ?\C-?)
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

(require 'misc)

(use-package ace-window
  :bind
  ("C-t" . ace-window)
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(bind-keys
 ("C-?"       . help-command)
 ("C-m"       . newline-and-indent)
 ("C-M-m"     . newline)
 ("C-x j"     . open-junk-file)
 ("C-S-n"     . make-frame)
 ("C-S-w"     . delete-frame)
 ("C-c n"     . multi-term-next)
 ("C-c v"     . revert-buffer)
 ("C-S-t"     . other-frame)
 ("C-M-%"     . ez-query-replace)
 ("C-x C-M-%" . ez-query-replace-repeat)
 ("C-c |"     . org-store-link)
 ("C-c C-z"   . window-resizer)
 ("<f8>"      . neotree-toggle)
 ("M-\\"      . dired)
 ("C-x C-j"   . skk-mode)
 ("C-x 3"     . split-window-right-and-balance)
 ("C-x 2"     . split-window-below-and-balance)
 ("C-x 0"     . delete-window-and-balance))

(setq windmove-wrap-around t)
