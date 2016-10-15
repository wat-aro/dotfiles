(use-package popwin
  :init
  (setq display-buffer-function 'popwin:display-buffer)
  :config
  (when (fboundp 'popwin:w3m-browse-url)
    (setq browse-url-browser-function 'popwin:w3m-browse-url))
  (setq popwin:special-display-config
        (append popwin:special-display-config
                '(("*w3m*")
                  ("*slime-apropos*")
                  ("*slime-macroexpansion*")
                  ("*slime-description*")
                  ("*slime-compilation*" :noselect t)
                  ("*slime-xref*")
                  (slime-connection-list-mode)
                  (sldb-mode :height 40 :stick t)
                  slime-repl-mode
                  slime-connection-list-mode
                  (direx:direx-mode :position left :width 25 :dedicated t)
                  ("*quickrun*")
                  (dired-mode :position top)
                  ("*Shell Command Output*")
                  (compilation-mode :noselect t)))))

;;; Color Theme
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

;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.90))

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)
