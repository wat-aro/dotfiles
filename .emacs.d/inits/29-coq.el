(setq auto-mode-alist (cons '("\\.v$" . coq-mode) auto-mode-alist))
(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)

(load "/usr/local/share/emacs/site-lisp/proof-general/generic/proof-site.el")
