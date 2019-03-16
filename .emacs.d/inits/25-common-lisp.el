;; Common Lisp
;; slime
(use-package slime :defer t
  :init
  (setq inferior-lisp-program "ros -L sbcl -Q run")
  (setf slime-lisp-implementations
        `((sbcl    ("sbcl" "--dynamic-space-size" "2000"))
          (roswell ("ros" "-Q" "run"))))
  (setf slime-default-lisp 'roswell))

;; ac-slime
(use-package ac-slime :defer t
  :hook
  (slime-mode . set-up-slime-ac)
  (slime-repl-mode . set-up-slime-ac))
