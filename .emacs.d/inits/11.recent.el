;; Recentf
(use-package recentf-ext
  :init
  (custom-set-variables
   '(recentf-max-saved-items 2000)
   '(recentf-auto-cleanup 600)
   '(recentf-exclude '("/recentf" "/elpa/" "/elisps/" "\\'/tmp/" "/\\.git/" "/\\.cask/"
                       "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores"))
   (list 'recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list)))
  (recentf-mode t)
  :bind
  ("C-c t" . helm-recentf))
