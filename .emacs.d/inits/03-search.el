;; anzu
(use-package anzu
  :init
  (global-anzu-mode +1)
  :custom
  (anzu-deactivate-region t)
  (anzu-mode-lighter "")
  (anzu-search-threshold 1000)
  (custom-safe-themes
   (quote
    ("bdaab014ec6785f64b72efbea80808b762d8971247aacf2ffc6b76a39b9ed97c" default)))
  (rspec-use-rake-when-possible nil)
  (tab-width 2)
  (anzu-use-migemo t))

(use-package migemo
  :custom
  (migemo-dictionary "/usr/share/migemo/utf-8/migemo-dict"))
(use-package dash)
(use-package s)



(defun ytn-ivy-migemo-re-builder (str)
  (let* ((sep " \\|\\^\\|\\.\\|\\*")
         (splitted (--map (s-join "" it)
                          (--partition-by (s-matches-p " \\|\\^\\|\\.\\|\\*" it)
                                          (s-split "" str t)))))
    (s-join "" (--map (cond ((s-equals? it " ") ".*?")
                            ((s-matches? sep it) it)
                            (t (migemo-get-pattern it)))
                      splitted))))

(setq ivy-re-builders-alist '((t . ivy--regex-plus)
                              (swiper . ytn-ivy-migemo-re-builder)))
