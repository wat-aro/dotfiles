;; ;; dired-k
(use-package dired-k :defer t
  :hook
  (dired-initial-position . dired-k)
  :bind
  (:map dired-mode-map
   ("K" . dired-k)
   ("C-t" . other-window)))

(use-package neotree
  :after
  projectile
  :commands
  (neotree-show neotree-hide neotree-dir neotree-find)
  :custom
  (neo-theme 'nerd2)
  (neo-show-hidden-files t)
  :bind
  ("C-M-\\" . neotree-projectile-toggle)
  :preface
  (defun neotree-projectile-toggle ()
    (interactive)
    (let ((project-dir
           (ignore-errors
             ;; Pick one: projectile or find-file-in-project
             (projectile-project-root)))
          (file-name (buffer-file-name))
          (neo-smart-open t))
      (if (and (fboundp 'neo-global--window-exists-p)
               (neo-global--window-exists-p))
          (neotree-hide)
        (progn
          (neotree-show)
          (if project-dir
              (neotree-dir project-dir))
          (if file-name
              (neotree-find file-name)))))))

(put 'dired-find-alternate-file 'disabled nil)
