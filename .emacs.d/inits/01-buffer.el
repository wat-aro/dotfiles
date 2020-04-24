;;; Bar
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode 0))

;; Column mode
(column-number-mode t)

;; 行番号の表示
(global-linum-mode)

;; 行番号フォーマット
(setq linum-format "%4d")

;; モードラインの割合表示を総行数表示
(defvar my-lines-page-mode t)
(defvar my-mode-line-format)

(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
         (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
        ((eq line-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
        ((eq column-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

  (setq mode-line-position
        '(:eval (format my-mode-line-format
                        (count-lines (point-max) (point-min))))))

;;; モードラインに時刻を表示する
(display-time)

;; Uniquify
(custom-set-variables
 '(uniquify-buffer-name-style 'post-forward-angle-brackets))
