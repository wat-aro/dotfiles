(use-package elm-mode
  :init
  (custom-set-variables '(elm-indent-offset 4))
  (add-hook 'flycheck-mode-hook #'flycheck-elm-setup)
  (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
  (add-hook 'elm-mode-hook
            (lambda ()
              (setq company-backends '(company-elm))))
  :config
  (flycheck-mode t))
