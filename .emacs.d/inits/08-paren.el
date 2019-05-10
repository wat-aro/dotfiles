;; paren
(show-paren-mode t)
(custom-set-variables
 '(show-paren-delay 0)
 '(parens-require-spaces nil))

;; Smartparens
(use-package smartparens
  :diminish
  smartparens-mode
  :init
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (sp-pair "<%" " %>"))

(use-package paredit :defer t
  :diminish paredit-mode
  :hook
  ((emacs-lisp-mode lisp-interacton-mode scheme-mode slime-mode inferior-scheme-mode slime-repl-mode) . enable-paredit-mode)
  :bind (:map paredit-mode-map
         ("C-<right>" . 'right-word)
         ("C-<left>"  . 'left-word)
         (";;"        . 'paredit-semicolon)
         (";"         . nil)
         ("C-j"       . nil)))
