;; multiple-cursors
(use-package multiple-cursors
  :init
  (use-package smartrep)
  (declare-function smartrep-define-key "smartrep")
  (global-unset-key (kbd "C-."))
  (smartrep-define-key global-map "C-."
    '(("C-'" . 'mc/mark-next-like-this)
      ("n"   . 'mc/mark-next-like-this)
      ("p"   . 'mc/mark-previous-like-this)
      ("m"   . 'mc/mark-more-like-this-extended)
      ("u"   . 'mc/unmark-next-like-this)
      ("U"   . 'mc/unmark-previous-like-this)
      ("s"   . 'mc/skip-to-next-like-this)
      ("S"   . 'mc/skip-to-previous-like-this)
      ("*"   . 'mc/mark-all-like-this)
      ("d"   . 'mc/mark-all-like-this-dwim)
      ("i"   . 'mc/insert-numbers)
      ("o"   . 'mc/sort-regions)
      ("O"   . 'mc/reverse-regions)))
  :bind  (("C-M-c" . mc/edit-lines)
          ("C-M-r" . mc/mark-all-in-region)))
