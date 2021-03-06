(use-package lsp-mode
  :ensure t
  :custom
  ;; debug
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental) ;; always send incremental document
  (lsp-response-timeout 5)
  ;; (lsp-enable-completion-at-point nil)
  (lsp-prefer-capf t)
  :hook
  ((rust-mode haskell-mode vue-mode ruby-mode go-mode) . lsp)
  (lsp-mode . yas-minor-mode)
  :bind
  (:map lsp-mode-map
        ("C-c R"   . lsp-rename)
        ("C-c C-j" . lsp-execute-code-action))
  :custom
  (lsp-rust-server 'rust-analyzer)
  (lsp-completion-provider :capf)
  (lsp-keymap-prefix "C-c C-l")
  (lsp-document-sync-method 2)
  (read-process-output-max 4000)
  :config
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection '("bundle" "exec" "solargraph" "stdio"))
                     :major-modes '(ruby-mode enh-ruby-mode)
                     :priority 0
                     :remote? t
                     :multi-root t
                     :server-id 'ruby-ls-remote
                     :initialized-fn (lambda (workspace)
                        (with-lsp-workspace workspace
                          (lsp--set-configuration
                            (lsp-configuration-section "solargraph"))))))
  (require 'lsp-rust)
  (lsp-register-client
    (make-lsp-client
      :new-connection (lsp-stdio-connection
                        (lambda ()
                          `(,(or (executable-find
                                   (cl-first lsp-rust-analyzer-server-command)
                                   t)
                               (lsp-package-path 'rust-analyzer)
                               "rust-analyzer")
                             ,@(cl-rest lsp-rust-analyzer-server-args))))
      :major-modes '(rust-mode rustic-mode)
      :remote? t
      :priority (if (eq lsp-rust-server 'rust-analyzer) 1 -1)
      :initialization-options 'lsp-rust-analyzer--make-init-options
      :notification-handlers (ht<-alist lsp-rust-notification-handlers)
      :action-handlers (ht ("rust-analyzer.runSingle" #'lsp-rust--analyzer-run-single))
      :library-folders-fn (lambda (_workspace) lsp-rust-library-directories)
      :after-open-fn (lambda ()
                       (when lsp-rust-analyzer-server-display-inlay-hints
                         (lsp-rust-analyzer-inlay-hints-mode)))
      :ignore-messages nil
      :server-id 'rust-analyzer-remote
      :custom-capabilities `((experimental . ((snippetTextEdit . ,(and lsp-enable-snippet (featurep 'yasnippet))))))))
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection '("rust-analyzer"))
                     :major-modes '(rust-mode rustic-mode)
                     :remote? t
                     :priority 2
                     :initialization-options 'lsp-rust-analyzer--make-init-options
                     :notification-handlers (ht<-alist lsp-rust-notification-handlers)
                     :action-handlers (ht ("rust-analyzer.runSingle" #'lsp-rust--analyzer-run-single))
                     :library-folders-fn (lambda (_workspace) lsp-rust-library-directories)
                     :after-open-fn (lambda ()
                       (when lsp-rust-analyzer-server-display-inlay-hints
                         (lsp-rust-analyzer-inlay-hints-mode)))
                     :ignore-messages nil
                     :server-id 'rust-analyzer-remote
                     :custom-capabilities `((experimental . ((snippetTextEdit . ,(and lsp-enable-snippet (featurep 'yasnippet))))))))
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection
                                       (lambda () (cons lsp-gopls-server-path lsp-gopls-server-args)))
                     :major-modes '(go-mode go-dot-mod-mode)
                     :priority 0
                     :remote? t
                     :server-id 'gopls-remote
                     :library-folders-fn 'lsp-clients-go--library-default-directories)))

(use-package lsp-ui
  :ensure t
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top) ;; top, bottom, or at-point
  (lsp-ui-doc-max-width 150)
  (lsp-ui-doc-max-height 30)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable t)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-ui-sideline-show-code-actions nil)
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable nil)
  (lsp-ui-imenu-kind-position 'top)
  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
  :preface
  (defun ladicle/toggle-lsp-ui-doc ()
    (interactive)
    (if lsp-ui-doc-mode
        (progn
          (lsp-ui-doc-mode -1)
          (lsp-ui-doc--hide-frame))
      (lsp-ui-doc-mode 1)))
  :bind
  (:map lsp-mode-map
        ("C-c C-r" . lsp-ui-peek-find-references)
        ("M-."     . lsp-ui-peek-find-definitions)
        ("C-c i"   . lsp-ui-peek-find-implementation)
        ("C-c m"   . lsp-ui-imenu)
        ("C-c s"   . lsp-ui-sideline-mode)
        ("C-c d"   . ladicle/toggle-lsp-ui-doc)
        ("C-c h"   . lsp-describe-thing-at-point))
  :hook
  (lsp-mode . lsp-ui-mode))
