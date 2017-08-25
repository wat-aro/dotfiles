  ;; multi-term
  ;; emacs に認識させたいキーがある場合は、term-unbind-key-list に追加する
  (require 'multi-term)
  (dolist (x '("C-q"))
    (add-to-list 'term-unbind-key-list x))
  ;; terminal に直接通したいキーがある場合は、term-unbind-key-listからdeleteする
  ;(dolist (x '("C-c"))
  ;  (delete x term-unbind-key-list))
  ;; term-mode-hook
  (add-hook
   'term-mode-hook
   '(lambda ()
      (define-key term-raw-map "\C-h" 'term-send-backspace)
      (define-key term-raw-map "\C-y" 'term-paste)
      (define-key term-raw-map "\C-t" 'other-window)
      (define-key term-raw-map term-view-toggle-key 'toggle-term-view)))
  ;; C-t で term-mode と fundamental-mode + view-modeを切り替える
  (setq term-view-toggle-key (kbd "C-q"))
  (defun toggle-term-view () (interactive)
         (cond ((eq major-mode 'term-mode)
                (fundamental-mode)
                (view-mode)
                (local-set-key term-view-toggle-key 'toggle-term-view)
                (setq multi-term-cursor-point (point)))
               ((eq major-mode 'fundamental-mode)
                (View-exit)
                (goto-char multi-term-cursor-point)
                (multi-term-internal))))
