;; White space
(use-package whitespace
  :custom
  (whitespace-display-mappings '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  :custom-face
  (whitespace-style (face trailing tabs space-mark tab-mark))
  (whitespace-trailing ((t (:foreground "magenta" :underline t :background nil))))
  :hook
  (before-save . delete-trailing-whitespace))

(use-package smart-hungry-delete
  :ensure t
  :bind (("<DEL>" . smart-hungry-delete-backward-char)
		     ("C-d" . smart-hungry-delete-forward-char))
  :defer nil ;; dont defer so we can add our functions to hooks
  :config (smart-hungry-delete-add-default-hooks)
  )
