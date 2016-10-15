;; Conf-Mode
(use-package generic-x
  :mode
  (("/\\.*conf\\(ig\\)?\\'" . conf-mode)
   ("/\\.*rc\\'" . conf-mode)
   ("/Gemfile.lock\\'" . conf-mode)))
