;;; setting for emacs-lisp
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

(defvar my/emacs-lisp-ac-sources
  '(ac-source-features ac-source-functions ac-source-variables ac-source-symbols))

(defun my/emacs-lisp-mode-hook ()
  "My Emacs Lisp mode."
  (setq ac-sources (append ac-sources my/emacs-lisp-ac-sources))
  (set-face-foreground 'font-lock-regexp-grouping-backslash "indian red")
  (set-face-foreground 'font-lock-regexp-grouping-construct "peru"))

(defvar my/emacs-lisp-modes
  '(emacs-lisp-mode-hook lisp-interaction-mode-hook ielm-mode-hook))

(--each my/emacs-lisp-modes
  (add-hook it 'turn-on-eldoc-mode)
  (add-hook it 'elisp-slime-nav-mode)
  (add-hook it 'my/emacs-lisp-mode-hook)
  (add-hook it 'auto-complete-mode))

(set-face-foreground 'font-lock-regexp-grouping-backslash "green3")
(set-face-foreground 'font-lock-regexp-grouping-construct "green")
