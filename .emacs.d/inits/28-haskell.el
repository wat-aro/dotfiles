;; (add-hook 'haskell-mode-hook 'hindent-mode)

;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

;; (require 'ac-haskell-process) ; if not installed via package.el
;; (add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
;; (add-hook 'haskell-interactive-mode-hook 'ac-haskell-process-setup)
;; (add-hook 'inferior-haskell-mode-hook 'ac-haskell-process-setup)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'haskell-interactive-mode))

;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (add-to-list 'completion-at-point-functions 'auto-complete))
;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-to-list 'ac-modes 'haskell-interactive-mode)
;; (add-hook 'haskell-interactive-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'haskell-mode-hook 'set-auto-complete-as-completion-at-point-function)

;; (eval-after-load 'haskell-mode
;;   '(define-key haskell-mode-map (kbd "C-c C-d") 'ac-haskell-process-popup-doc))

;; (add-hook 'haskell-mode-hook
;;           '(lambda ()
;;              (setq flycheck-checker 'haskell-hlint)
;;              (flycheck-mode 1)))
(use-package haskell-mode
  :init
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (add-hook 'haskell-mode-hook 'haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
  (custom-set-variables '(haskell-compile-cabal-build-command "stack build")
                        '(haskell-process-type 'stack-ghci)
                        '(haskell-process-path-ghci "stack")
                        '(haskell-process-args-ghci "ghci")
                        '(haskell-indent-thenelse 4)
                        '(haskell-stylish-on-save t)
                        '(haskell-process-suggest-remove-import-lines t)
                        '(haskell-process-auto-import-loaded-modules t)
                        '(haskell-process-log t))
  :bind (:map haskell-mode-map
              ("C-c C-l" . haskell-process-load-or-reload)
              ("C-j"     . haskell-indentation-newline-and-indent)
              ("C-c C-?" . haskell-hoogle)
              ("C-c C-c" . haskell-compile))
  :config
  (bind-keys :map haskell-indentation-mode-map
             (";" . nil)))

(use-package haskell-interactive-mode
  :bind (:map haskell-interactive-mode-map
              ("M-."     . haskell-mode-goto-loc)
              ("C-c C-t" . haskell-mode-show-type-at)))

(use-package haskell-cabal
  :mode
  ("\\.cabal\\'" . haskell-cabal-mode)
  :bind (:map haskell-cabal-mode-map
              ("C-c C-c" . haskell-compile)))
