(use-package popwin
  :init
  (setq display-buffer-function 'popwin:display-buffer)
  :config
  (when (fboundp 'popwin:w3m-browse-url)
    (setq browse-url-browser-function 'popwin:w3m-browse-url))
  (setq popwin:popup-window-height 0.4)
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
                  (direx:direx-mode :position left :width 40 :dedicated t)
                  ("*quickrun*")
                  (dired-mode :position top)
                  ("*Shell Command Output*")
                  (compilation-mode :noselect t)))))

;;; Color Theme
(load-theme 'atom-one-dark t)
;; (load-theme 'flatland t)
;; (load-theme 'hamburg t)
;; (load-theme 'clues t)
;; (load-theme 'gotham t)

(custom-set-faces
 '(linum ((t (:inherit (shadow default) :foreground "Gray")))))

(set-face-foreground 'region "Black")
(set-face-background 'region "MediumPurple4")

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
(set-frame-parameter (selected-frame) 'alpha '(1.0))

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

(setq
 ;; ホイールでスクロールする行数を設定
 mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control)))
 ;; スクロール中のカーソルの位置を固定する
 scroll-preserve-screen-position 'always
 )

;; カーソルの行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "OliveDrab1"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " Ys")
    (paredit-mode . " Pe")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . " Ut")
    (elisp-slime-nav-mode . " EN")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    ;; Major modes
    (emacs-lisp-mode . "El")
    (lisp-interaction-mode . "Li")
    (python-mode . "Py")
    (ruby-mode   . "Rb")
    (emacs-lisp-mode . "El")
    (markdown-mode . "Md")))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)
