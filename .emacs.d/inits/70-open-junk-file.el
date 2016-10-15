;; Open junk file
(use-package open-junk-file
  :init
  (custom-set-variables
   '(open-junk-file-format "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S."))
  (bind-key "C-x j" 'open-junk-file))
