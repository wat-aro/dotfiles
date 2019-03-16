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
  (emacs-lisp-mode      . enable-paredit-mode)
  (lisp-interacton-mode . enable-paredit-mode)
  (scheme-mode          . enable-paredit-mode)
  (slime-mode           . enable-paredit-mode)
  (inferior-scheme-mode . enable-paredit-mode)
  (slime-repl-mode      . enable-paredit-mode)
  :bind (:map paredit-mode-map
         ("C-<right>" . 'right-word)
         ("C-<left>"  . 'left-word)
         (";;"        . 'paredit-semicolon)
         (";"         . nil)))
