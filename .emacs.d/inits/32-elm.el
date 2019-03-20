(use-package elm-mode
  :custom
  (elm-indent-offset 4)
  (elm-tags-on-save t)
  (elm-tags-exclude-elm-stuff . nil)
  :hook
  (elm-mode . elm-oracle-setup-completion)
  (elm-mode . (lambda ()
                (company-mode)
                (setq company-backends '(company-elm))))
  (flycheck-mode . flycheck-elm-setup)
  (company . (lambda () (add-to-list 'company-backends 'company-elm)))
  (before-save . my-elm-mode-before-save-hook)
  :config
  (flycheck-mode t)
  (add-to-list 'company-backends 'company-elm)
  ;; (global-company-mode)
)

(defun my-elm-mode-before-save-hook ()
  (when (eq major-mode 'elm-mode)
    (elm-mode-format-buffer)))
