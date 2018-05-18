(use-package rjsx-mode
  :init
  (add-hook 'rjsx-mode-hook (lambda ()
                             (tern-mode t)
                             (flycheck-mode t)))
  (add-to-list 'interpreter-mode-alist '("node" . rjsx-mode))
  :mode (("\\.js\\'" . rjsx-mode)
         ("\\.json\\'" . rjsx-mode)
         ("\\.jsx\\'" . js2-jsx-mode)
         ("\\.eslintrc.*$" . json-mode)
         ("\\.babelrc$" . json-mode))
  :config
  (custom-set-variables '(js2-basic-offset 2))
  (bind-keys :map rjsx-mode-map
             ("C-c C-e" . nodejs-repl-send-last-sexp)
             ("C-c C-l" . nodejs-repl-load-file)
             ("C-c C-b" . nodejs-repl-send-buffer)
             ("C-c C-g" . nodejs-repl-send-region))
  (setq js2-include-browser-externs nil)
  (setq rjsx-mode-show-parse-errors nil)
  (setq rjsx-mode-show-strict-warnings nil)
  (setq js2-highlight-external-variables nil)
  (setq js2-include-jslint-globals nil)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override nil)
  (setq js2-strict-inconsistent-return-warning nil))

(use-package tern
  :config
  (use-package tern-auto-complete)
  (tern-ac-setup))

(use-package nodejs-repl
  :init
  (add-hook 'rjsx-mode-hook (lambda () (tern-mode t))))
