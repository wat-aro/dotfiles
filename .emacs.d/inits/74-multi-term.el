(use-package multi-term
  :custom
  (multi-term-program shell-file-name)
  :bind
  (("C-c C-t" . multi-term)
   :map term-raw-map
   ("C-c C-p" . multi-term-prev)
   ("C-c C-n" . multi-term-next)
   ("C-c C-j" . toggle-term-mode)
   ("C-t"     . other-window)
   ("C-p"     . term-send-up)
   ("C-n"     . term-send-down)
   :map term-mode-map
   ("C-c C-p" . multi-term-prev)
   ("C-c C-n" . multi-term-next)
   ("C-c C-j" . toggle-term-mode)
   ("C-t"     . other-window)))

(defun toggle-term-mode()
  "Toggles term mode(line <--> char)"
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))
