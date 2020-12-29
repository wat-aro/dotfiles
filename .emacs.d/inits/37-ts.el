(use-package typescript-mode :defer t
  :custom
  (typescript-indent-level 2)
  :mode (("\\.ts\\'"  . typescript-mode)
         ("\\.tsx\\'" . typescript-mode)))
