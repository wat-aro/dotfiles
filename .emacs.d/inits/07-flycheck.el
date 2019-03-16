;; Flycheck
(use-package flycheck
  :ensure t
  :bind (("M-g l" . flycheck-list-errors))
  :custom
  (flycheck-display-errors-delay 0.5)
  (flycheck-idle-change-delay 1.0)
  (flycheck-display-errors-function nil)
  (flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
  :hook
  (ruby-mode . flycheck-mode)
  (flycheck . flycheck-pos-tip-mode))
