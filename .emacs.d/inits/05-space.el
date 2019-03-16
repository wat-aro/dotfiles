;; White space
(use-package whitespace
  :custom
  (whitespace-display-mappings '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  :custom-face
  (whitespace-style (face trailing tabs space-mark tab-mark))
  (whitespace-trailing ((t (:foreground "magenta" :underline t :background nil))))
  :hook
  (before-save . delete-trailing-whitespace))
