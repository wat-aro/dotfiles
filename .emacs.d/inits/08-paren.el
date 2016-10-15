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
  :init
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-mode-hook 'enable-paredit-mode)
  (add-hook 'inferior-scheme-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  :config
  (bind-keys :map paredit-mode-map
             ("C-<right>" . 'right-word)
             ("C-<left>"  . 'left-word)))
