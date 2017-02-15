;; Projectile
(use-package projectile :defer t
  :config
  (use-package helm-projectile)
  (custom-set-variables
   '(projectile-completion-system 'helm))
  (projectile-global-mode t)
  (helm-projectile-on))

(use-package projectile-rails
  :config
  (projectile-rails-global-mode))
