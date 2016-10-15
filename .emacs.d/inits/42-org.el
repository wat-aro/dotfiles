;; org
(use-package org
  :config
  (use-package ob-ruby)
  (setq org-directory "~/Documents/junk")
  (setq org-agenda-files (list org-directory))

  (setq org-src-fontify-natively t)

  (defun my-org-confirm-babel-evaluate (lang body)
    (not (or (string= lang "ditaa")
             (string= lang "emacs-lisp")
             (string= lang "ruby")
             (string= lang "C")
             (string= lang "cpp")
             )))
  (setq org-hide-leading-stars t)
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate))
