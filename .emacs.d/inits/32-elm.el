(use-package elm-mode
  :init
  (custom-set-variables '(elm-indent-offset 4)
                        '(elm-tags-on-save t))
  (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
  (add-to-list 'company-backends 'company-elm)
  (add-hook 'elm-mode-hook
            (lambda ()
              (setq company-backends '(company-elm))))
  (with-eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))
  :config
  (flycheck-mode t)
  ;; (global-company-mode)
  )

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-elm))
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
(add-hook 'before-save-hook #'my-elm-mode-before-save-hook)

(defun my-elm-mode-before-save-hook ()
  (when (eq major-mode 'elm-mode)
    (elm-mode-format-buffer)))
