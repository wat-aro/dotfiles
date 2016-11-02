;; Common Lisp
;; slime
(use-package slime :defer t
  :init
  (setq inferior-lisp-program "ros -L sbcl -Q run")
  (setf slime-lisp-implementations
        `((sbcl    ("sbcl" "--dynamic-space-size" "2000"))
          (roswell ("ros" "-Q" "run"))))
  (setf slime-default-lisp 'roswell)
  :config
  ;; (setq display-buffer-function 'popwin:display-buffer)
  )

;; ac-slime
(use-package ac-slime :defer t
  :init
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac))
