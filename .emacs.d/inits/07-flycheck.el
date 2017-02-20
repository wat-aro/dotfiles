;; Flycheck
(use-package flycheck
  :ensure t
  :bind (("M-g l" . flycheck-list-errors))
  :config
  (custom-set-variables
   '(flycheck-display-errors-delay 0.5)
   '(flycheck-idle-change-delay 1.0)
   '(flycheck-display-errors-function nil)))

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
