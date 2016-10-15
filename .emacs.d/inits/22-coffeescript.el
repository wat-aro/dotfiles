(use-package coffee-mode :defer t
  :mode (("\\.js\\.coffee\\'" . coffee-mode)
         ("\\.coffee\\'" . coffee))
  :bind (("C-j" . 'coffee-newline-and-indent))
  :config
  (custom-set-variables
   '(coffee-tab-width 2)
   '(coffee-indent-like-python-mode t)))
