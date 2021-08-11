;; org
(use-package org :defer t
  :custom
  (org-agenda-files (list "~/Dropbox/org/tasks.org" "~/Dropbox/org/notes.org" "~/Dropbox/org/schedule.org"))
  (org-hide-leading-stars t)
  (org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
  (org-todo-keywords '((sequence "TODO" "DOING" "DONE")))
  (org-use-speed-commands t)
  (org-startup-truncated nil)
  (org-capture-templates '(("t" "Task" entry (file+headline "~/Dropbox/org/tasks.org" "Tasks") "** TODO %? \n")
                            ("n" "Note" entry (file+headline "~/Dropbox/org/notes.org" "Notes"))
                            ("s" "Schedule" entry (file+headline "~/Dropbox/org/schedule.org" "Schedule") "** %?\n   SCHEDULED: %t")))
  :bind
  ("C-c c" . org-capture)
  ("C-c a" . org-agenda)
  :config
  (setq org-src-fontify-natively t)
  (toggle-truncate-lines t)
  (defun my-org-confirm-babel-evaluate (lang body)
    (not (or (string= lang "ditaa")
             (string= lang "emacs-lisp")
             (string= lang "ruby")
             (string= lang "C")
             (string= lang "cpp")
           (string= lang "python")))))

(use-package org-bullets
  ;;:custom (org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" ""))
  :hook (org-mode . org-bullets-mode))

;; (require 'gcal)
;; (custom-set-variables
;;   '(gcal-client-id "571208440954-51sfhhnq3bi0dqq0lcnflupvrf3cqd84.apps.googleusercontent.com")
;;   '(gcal-client-secret "ugSA1DZBEjaY4Z4tiSXN5xNq"))

;; (require 'gcal-org)

;; (gcal-org-pull-oevents
;;   "kazutaro.ishida@esm.co.jp"
;;   `((timeMin . ,(gcal-time-format (current-time) nil))))
