;;; Ocaml
;;; tuareg
(use-package tuareg :defer t
  :mode (("\\.ml[iylp]?" . tuareg-mode))
  :commands (tuareg-mode tuareg-run-ocaml ocamldebug)
  :config
  (setq tuareg-use-smie nil))

;; (autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)

(use-package merlin :defer t
  :init
  (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
  :hook
  ((tuareg-mode caml-mode) . merlin-mode)
  :config
  (setq merlin-command 'opam)
  (setq merlin-error-after-save nil)
  (require 'opam-user-setup "~/.emacs.d/elisp/opam-user-setup.el"))
