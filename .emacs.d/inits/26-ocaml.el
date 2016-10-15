;;; Ocaml
;;; tuareg
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
(setq tuareg-use-smie nil)

;;; merlin
;; Add opam emacs directory to the load-path
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
;; Load merlin-mode
(require 'merlin)
;; (push "<SHARE_DIR>/emacs/site-lisp" load-path) ; directory containing merlin.el
(autoload 'merlin-mode "merlin" "Merlin mode" t)
;; Start merlin on ocaml files
(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)
;; Enable auto-complete
(add-hook 'merlin-mode-hook
          (lambda ()
            (setq ac-sources (append ac-sources '(merlin-ac-source)))))
;; Use opam switch to lookup ocamlmerlin binary
(setq merlin-command 'opam)

;; ;;; flycheck OCaml
(with-eval-after-load 'merlin
  ;; Disable Merlin's own error checking
  (setq merlin-error-after-save nil)
  ;; Enable Flycheck checker
  (flycheck-ocaml-setup))
