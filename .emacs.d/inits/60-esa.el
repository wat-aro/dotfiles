(use-package esa
  :init
  (setq esa-token (string-trim (get-string-from-file "~/Dropbox/.esa")))
  (setq esa-team-name "esminc"))
