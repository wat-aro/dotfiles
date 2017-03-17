;; exchange meta-key to super-key
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier 'super)

;;; Key
;;(keyboard-translate ?\C-h ?\C-?)
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

(bind-keys
 ("C-?"   . help-command)
 ("C-t"   . other-window)
 ("C-j"   . newline-and-indent)
 ("C-x j" . open-junk-file)
 ("C-S-n" . make-frame)
 ("C-S-w" . delete-frame)
 ("C-M-y" . helm-show-kill-ring)
 ("C-c n" . multi-term-next)
 ("C-c v" . revert-buffer)
 ("C-S-t" . other-frame)
 ("C-M-%" . ez-query-replace)
 ("C-x C-M-%" . ez-query-replace-repeat))

(custom-set-variables
 '(key-chord-two-keys-delay 0.01))
(key-chord-mode t)
(key-chord-define-global "df" 'find-function)
(key-chord-define-global "fh" 'describe-function)
(key-chord-define-global "fv" 'find-variable)
(key-chord-define-global "pk" 'package-install)
(key-chord-define-global "kl" 'align-regexp)
(key-chord-define-global "dv" 'describe-variable)
