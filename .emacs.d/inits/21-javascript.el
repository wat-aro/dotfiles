;; (use-package rjsx-mode
;;   :init
;;   (add-to-list 'interpreter-mode-alist '("node" . rjsx-mode))
;;   :mode (("\\.js\\'" . rjsx-mode)
;;          ("\\.jsx\\'" . js2-jsx-mode)
;;          ("\\.eslintrc.*$" . json-mode)
;;          ("\\.babelrc$" . json-mode))
;;   :custom
;;   (js2-basic-offset 2)
;;   (js2-include-browser-externs nil)
;;   (rjsx-mode-show-parse-errors nil)
;;   (rjsx-mode-show-strict-warnings nil)
;;   (js2-highlight-external-variables nil)
;;   (js2-include-jslint-globals nil)
;;   (js2-strict-missing-semi-warning nil)
;;   (js2-missing-semi-one-line-override nil)
;;   (js2-strict-inconsistent-return-warning nil)
;;   :bind
;;   (:map rjsx-mode-map
;;    ("C-c C-e" . nodejs-repl-send-last-sexp)
;;    ("C-c C-l" . nodejs-repl-load-file)
;;    ("C-c C-b" . nodejs-repl-send-buffer)
;;    ("C-c C-g" . nodejs-repl-send-region)))

(use-package tern :defer t
  ;; :config
  ;; (use-package tern-auto-complete)
  ;; (tern-ac-setup)
  )

(use-package vue-mode :defer t)
