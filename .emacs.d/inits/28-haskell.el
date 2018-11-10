(require 'lsp-mode)
(require 'lsp-ui)
(require 'lsp-haskell)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'haskell-mode-hook #'lsp-haskell-enable)
  (add-hook 'haskell-mode-hook 'flycheck-mode)




;; (use-package haskell-mode
;;   :init
;;   (add-hook 'haskell-mode-hook (lambda ()
;;                                  (haskell-indentation-mode)
;;                                  (interactive-haskell-mode)
;;                                  (haskell-decl-scan-mode)
;;                                  (haskell-doc-mode)
;;                                  (haskell-auto-insert-module-template)
;;                                  (ghc-init)
;;                                  (flycheck-mode t)
;;                                  ))
;;   (custom-set-variables '(haskell-compile-cabal-build-command "stack build")
;;                         '(haskell-process-type 'stack-ghci)
;;                         '(haskell-process-path-ghci "stack")
;;                         '(haskell-process-args-ghci "ghci")
;;                         '(haskell-indent-thenelse 4)
;;                         '(haskell-stylish-on-save t)
;;                         '(haskell-process-suggest-remove-import-lines t)
;;                         '(haskell-process-auto-import-loaded-modules t)
;;                         '(haskell-process-log t)
;;                         '(haskell-indentation-layout-offset 4)
;;                         '(haskell-indentation-starter-offset 4)
;;                         '(haskell-indentation-left-offset 4)
;;                         '(hasKell-indentation-where-pre-offset 2)
;;                         '(haskell-indentation-where-post-offset 2))
;;   :bind (:map haskell-mode-map
;;               ("C-c C-l" . haskell-process-load-or-reload)
;;               ("C-j"     . haskell-indentation-newline-and-indent)
;;               ("C-c C-?" . haskell-hoogle)
;;               ("C-c C-c" . haskell-compile)
;;               ("C-c C-d" . ac-haskell-process-popup-doc)
;;               :map haskell-indentation-mode-map
;;               (";" . nil)))

;; (use-package haskell-interactive-mode
;;   :bind (:map haskell-interactive-mode-map
;;               ("M-."     . haskell-mode-goto-loc)
;;               ("C-c C-t" . haskell-mode-show-type-at)))

;; (use-package haskell-cabal
;;   :mode
;;   ("\\.cabal\\'" . haskell-cabal-mode)
;;   :bind (:map haskell-cabal-mode-map
;;               ("C-c C-c" . haskell-compile)))

;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (add-to-list 'completion-at-point-functions 'auto-complete))

;; (use-package ac-haskell-process
;;   :init
;;   (add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
;;   (add-hook 'haskell-interactive-mode-hook 'ac-haskell-process-setup)
;;   (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;   (add-to-list 'ac-modes 'haskell-interactive-mode)
;;   (add-hook 'haskell-interactive-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;   (add-hook 'haskell-mode-hook 'set-auto-complete-as-completion-at-point-function))
