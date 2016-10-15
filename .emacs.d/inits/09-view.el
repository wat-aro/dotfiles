;; view-mode
(custom-set-variables
 '(view-read-only t))

(use-package view
  :bind (("N" . 'View-search-last-regexp-backward)
         ("?" . 'View-search-regexp-backward?)
         ("g" . 'View-goto-line)
         ("w" . 'forward-word)
         ("W" . 'forward-symbol)
         ("b" . 'backward-word)
         ("h" . 'backward-char)
         ("j" . 'next-line)
         ("k" . 'previous-line)
         ("l" . 'forward-char)
         ("[" . 'backward-paragraph)
         ("]" . 'forward-paragraph)))

(use-package doc-view
  ("j" . 'doc-view-next-line-or-next-page)
  ("k" . 'doc-view-previous-line-or-previous-page))
