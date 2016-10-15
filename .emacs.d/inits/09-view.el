;; view-mode
(custom-set-variables
 '(view-read-only t))

(use-package doc-view
  :bind (("j" . doc-view-next-line-or-next-page)
         ("k" . doc-view-previous-line-or-previous-page)))
