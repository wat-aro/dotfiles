;; Open junk file
(use-package open-junk-file
  :custom
  (open-junk-file-format "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S.")
  :bind
  ("C-x j" . open-junk-file)
  ("C-x J" . open-junk-file-directory))

(defun open-junk-file-directory ()
  (interactive)
  (counsel-dired-jump "~/Documents/junk/"))
