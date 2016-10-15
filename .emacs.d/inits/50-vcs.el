;; Magit
;; (use-package magit :defer t)
(setq-default magit-auto-revert-mode nil)
(setq vc-handled-backends '())
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))
(bind-key "C-x m" 'magit-status)
(bind-key "C-c l" 'magit-blame)
;; (use-package magit-find-file :defer t)
(bind-key "M-t" 'magit-find-file-completing-read)
