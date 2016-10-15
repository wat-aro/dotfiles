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

;;; color-theme
;; (load-theme 'flatland t)
;; (load-theme 'hamburg t)
(load-theme 'clues t)
;; (load-theme 'gotham t)
;; (load-theme 'vsc t)

;;; インタラクティブにウィンドウを分割
(setq split-height-threshold nil)
(setq split-width-threshold 150)

;;; splash screenを無効にする
(setq inhibit-splash-screen t)

;;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;;; タイトルバーにファイルのフルパス表示
(setq frame-title-format "%f")

;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)

;; Uniquify
(custom-set-variables
 '(uniquify-buffer-name-style 'post-forward-angle-brackets))
