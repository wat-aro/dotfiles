;;; Ocaml
;;; tuareg
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
(setq tuareg-use-smie nil)

(use-package merlin
  :init
  (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
  (add-hook 'tuareg-mode-hook 'merlin-mode)
  (add-hook 'caml-mode-hook 'merlin-mode)
  (add-hook 'merlin-mode-hook
          (lambda ()
            (setq ac-sources (append ac-sources '(merlin-ac-source)))))
  :config
  (setq merlin-command 'opam)
  (setq merlin-error-after-save nil)
  (flycheck-ocaml-setup))
