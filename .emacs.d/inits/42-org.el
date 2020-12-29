;; org
(use-package org :defer t
  :custom
  (org-directory "~/Documents/junk")
  (org-agenda-files (list org-directory))
  (org-hide-leading-stars t)
  (org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
  (org-todo-keywords '((sequence "TODO" "DOING" "DONE")))
  (org-use-speed-commands t)
  :config
  (setq org-src-fontify-natively t)

  (defun my-org-confirm-babel-evaluate (lang body)
    (not (or (string= lang "ditaa")
             (string= lang "emacs-lisp")
             (string= lang "ruby")
             (string= lang "C")
             (string= lang "cpp")
             (string= lang "python")))))
