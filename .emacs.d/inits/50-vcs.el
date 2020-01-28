;; Magit
(use-package magit
  :defer t
  :custom
  (magit-auto-revert-mode nil)
  (vc-handled-backends '())
  :bind (("C-x m" . magit-status)
         ("C-c l" . magit-blame))
  :hook
  (vc . (remove-hook 'find-file-hooks 'vc-find-file-hook)))
