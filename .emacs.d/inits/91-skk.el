(straight-use-package 'ddskk)
(require 'skk)
(define-globalized-minor-mode global-skk-latin-mode skk-latin-mode skk-latin-mode-on)
(global-skk-latin-mode)
(bind-key "C-x C-j" 'skk-mode)

;; (use-package sticky
;;   :config
;;   (use-sticky-key ?\; sticky-alist:en))
