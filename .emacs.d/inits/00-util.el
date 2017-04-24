;;; Backupfile
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))
(setq auto-save-list-file-prefix "~/.emacs.d/backups/")
(setq create-lockfiles nil)

;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)

;;; Font
(set-face-attribute 'default nil :family "Ricty" :height 160)

;;; Tab
(setq-default indent-tabs-mode nil)

;; ピープ音を鳴らさない
(setq visible-bell t)
(setq ring-bell-function 'ignore)

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

;; volatile-highlights.el
;; (use-package volatile-highlights
;;   :diminish volatile-highlights-mode
;;   :config
;;   (volatile-highlights-mode nil))

;; 自動でバッファの再読み込み
(global-auto-revert-mode 1)

;; (smart-newline-mode 1)

;; ファイルの読み込み位置を保存する
(save-place-mode 1)
