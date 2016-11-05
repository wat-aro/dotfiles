;; Projectile
(use-package projectile :defer t
  :init (add-hook 'projectile-mode-hook 'projectile-rails-on)
  :config
  (use-package helm-projectile)
  (custom-set-variables
   '(projectile-completion-system 'helm))
  (projectile-global-mode t)
  (helm-projectile-on))
