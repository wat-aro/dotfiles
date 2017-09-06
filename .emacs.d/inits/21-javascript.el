(use-package js2-mode
  :init
  (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode t)
                             (flycheck-mode t)))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  :mode (("\\.js\\'" . js2-mode)
         ("\\.json\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode)
         ("\\.eslintrc.*$" . json-mode)
         ("\\.babelrc$" . json-mode))
  :config
  (custom-set-variables '(js2-basic-offset 2))
  (bind-keys :map js2-mode-map
             ("C-c C-e" . nodejs-repl-send-last-sexp)
             ("C-c C-l" . nodejs-repl-load-file)
             ("C-c C-b" . nodejs-repl-send-buffer)
             ("C-c C-g" . nodejs-repl-send-region))
  (setq js2-include-browser-externs nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (setq js2-highlight-external-variables nil)
  (setq js2-include-jslint-globals nil))

(use-package tern
  :config
  (use-package tern-auto-complete)
  (tern-ac-setup))

(use-package nodejs-repl
  :init
  (add-hook 'js2-mode-hook (lambda () (tern-mode t))))
