;; Projectile
(use-package projectile :defer t
  :init
  (use-package helm-projectile)
  (projectile-global-mode t)
  (helm-projectile-on)
  :custom
  (projectile-completion-system 'helm)
  (projectile-mode-line
   '(:eval (format " Projectile[%s]"
                   (projectile-project-name))))
  :bind
  ("C-c p" . projectile-command-map))

(use-package projectile-rails
  :config
  (projectile-rails-global-mode))
