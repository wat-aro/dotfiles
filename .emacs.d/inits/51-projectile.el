;; Projectile
(use-package projectile :defer t
  :init
  (setq projectile-completion-system 'ivy)
  :custom
  (projectile-mode-line
   '(:eval (format " Projectile[%s]"
                   (projectile-project-name))))
  :bind
  ("C-c p" . projectile-command-map))
