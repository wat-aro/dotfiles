(use-package annotate
  :custom
  (annotate-file "~/.emacs.d/annotations")
  :hook
  (find-file . annotate-mode)
  :bind (:map annotate-mode-map
              ("C-c a" . annotate-annotate)))
