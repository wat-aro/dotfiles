;; Flycheck
(use-package flycheck
  :ensure t
  :config
  (custom-set-variables
   '(flycheck-display-errors-delay 0.5)
   '(flycheck-idle-change-delay 1.0)
   '(flycheck-display-errors-function nil))
  (bind-keys :map flycheck-command-map
             ("M-g l" . flycheck-list-errors)))
