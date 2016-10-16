;; Magit
;; (use-package magit :defer t)
(use-package magit
  :bind (("C-x m" . magit-status)
         ("C-c l" . magit-blame)
         ("M-t" . magit-find-file-completing-read))
  :config
  (setq-default magit-auto-revert-mode nil)
  (setq vc-handled-backends '())
  (eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook)))
