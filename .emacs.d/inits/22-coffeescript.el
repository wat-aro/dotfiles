(use-package coffee-mode :defer t
  :mode (("\\.js\\.coffee\\'" . coffee-mode)
         ("\\.coffee\\'" . coffee-mode))
  :config
  (custom-set-variables
   '(coffee-tab-width 2)
   '(coffee-indent-like-python-mode t))
  (bind-keys :map coffee-mode-map
             ("C-j" . coffee-newline-and-indent)))
