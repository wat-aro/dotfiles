(use-package clojure-mode
  :hook
  (clojure-mode . paredit-mode)
  :custom
  (clojure-align-forms-automatically t))

(use-package cider
  :hook
  (cider-mode . clj-refactor-mode)
  ((cider-mode cider-repl-mode) . company-mode)
  ((cider-mode cider-repl-mode) . eldoc-mode)
  ((cider-mode cider-repl-mode) . paredit-mode)
  (cider-mode . helm-cider-mode)
  (cider-repl-mode . helm-cider-mode)
  :diminish subword-mode
  :custom
  (nrepl-log-messages t)
  (cider-repl-display-in-current-window t)
  (cider-repl-use-clojure-font-lock t)
  (cider-prompt-save-file-on-load 'always-save)
  (cider-font-lock-dynamically '(macro core function var))
  (cider-overlays-use-font-lock t)
  :config
  (cider-repl-toggle-pretty-printing))
