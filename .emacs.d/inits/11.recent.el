;; Recentf
(use-package recentf-ext
  :custom
  (recentf-max-saved-items 2000)
  (recentf-auto-cleanup 'never)
  (recentf-exclude '("/recentf" "/elpa/" "/elisps/" "\\'/tmp/" "/\\.git/" "/\\.cask/"
                     "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores"))
  :init
  (custom-set-variables
   (list 'recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list)))
  (recentf-mode t)
  :bind
  ("C-c f" . helm-recentf))
