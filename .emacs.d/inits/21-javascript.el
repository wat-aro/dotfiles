(use-package js2-mode
  :init
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  :mode (("\\.js\\'" . js2-mode)
         ("\\.json\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :config
  (custom-set-variables '(js2-basic-offset 2))
  (bind-keys :map js2-mode-map
             ("C-c C-e" . nodejs-repl-send-last-sexp)
             ("C-c C-l" . nodejs-repl-load-file)
             ("C-c C-b" . nodejs-repl-send-buffer)
             ("C-c C-g" . nodejs-repl-send-region)))

(use-package tern
  :config
  (use-package tern-auto-complete)
  (tern-ac-setup))

(use-package nodejs-repl
  :init
  (add-hook 'js2-mode-hook (lambda () (tern-mode t))))
