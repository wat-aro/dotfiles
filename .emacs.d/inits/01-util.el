;;; Backupfile
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))


;;; Font
(set-face-attribute 'default nil :family "Ricty" :height 160)

;;; Bar
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1))
(menu-bar-mode -1)


;;; Tab
(setq-default indent-tabs-mode nil)

;; ピープ音を鳴らさない
(setq visible-bell t)
(setq ring-bell-function 'ignore)



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

;;; splash screenを無効にする
(setq inhibit-splash-screen t)

;;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;;; タイトルバーにファイルのフルパス表示
(setq frame-title-format "%f")

;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)

;;; C-u C-SPC C-SPC ...でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)

;;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;;; ファイルを開いた位置を保存する
(use-package saveplace
  :init
  (setq-default save-place t)
  (setq save-place-file (concat user-emacs-directory "places")))

;;; ミニバッファ履歴を次回Emacs起動時にも保存する
(savehist-mode 1)

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

;; volatile-highlights.el
(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :init
  (volatile-highlights-mode t))

;;; Key
(progn
  (bind-key  "C-?"   'help-command)
  (bind-key* "C-t"   'other-window)
  (bind-key  "C-j"   'newline-and-indent)
  (bind-key  "C-S-n" 'make-frame)
  (bind-key  "C-S-w" 'delete-frame)
  (bind-key  "C-M-y" 'helm-show-kill-ring)
  (bind-key  "C-c n" 'multi-term-next)
  (bind-key  "C-c v" 'revert-buffer)
  (bind-key  "C-s-t" 'other-frame))

(keyboard-translate ?\C-h ?\C-?)

;; exchange meta-key to super-key
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier 'super)

(custom-set-variables
 '(key-chord-two-keys-delay 0.01))
(key-chord-mode t)
(key-chord-define-global "df" 'find-function)
(key-chord-define-global "fh" 'describe-function)
(key-chord-define-global "fv" 'find-variable)
(key-chord-define-global "pk" 'package-install)
(key-chord-define-global "kl" 'align-regexp)
(key-chord-define-global "dv" 'describe-variable)
