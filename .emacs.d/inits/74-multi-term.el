(require 'multi-term)

(defun toggle-term-mode()
  "Toggles term mode(line <--> char)"
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))

(setq multi-term-program shell-file-name)

(global-set-key "\C-c\C-t" 'multi-term)

;; keybinds for multi-term
(defun term-mode-hooks ()
  ;term-char
  (define-key term-raw-map (kbd "C-c C-p") 'multi-term-prev)
  (define-key term-raw-map (kbd "C-c C-n") 'multi-term-next)
  (define-key term-raw-map (kbd "C-c C-j") 'toggle-term-mode)
  (define-key term-raw-map (kbd "C-t") 'other-window)

  (define-key term-raw-map (kbd "C-p") 'term-send-up)
  (define-key term-raw-map (kbd "C-n") 'term-send-down)

  ;term-line
  (define-key term-mode-map (kbd "C-c C-p") 'multi-term-prev)
  (define-key term-mode-map (kbd "C-c C-n") 'multi-term-next)
  (define-key term-mode-map (kbd "C-c C-j") 'toggle-term-mode)
  (define-key term-mode-map (kbd "C-t") 'other-window))


(add-hook 'term-mode-hook 'term-mode-hooks)
