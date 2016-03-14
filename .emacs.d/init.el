;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ------------------------------------------------------------------------

;; 文字コード
(cond
 ((eq system-type 'gnu/linux)
  (prefer-coding-system 'utf-8)
  (setq coding-system-for-read 'utf-8)
  (setq coding-system-for-write 'utf-8))
 ((eq system-type 'darwin)
  (set-default-coding-systems 'utf-8-unix)
  (set-terminal-coding-system 'utf-8-unix)
  (set-keyboard-coding-system 'utf-8-unix)
  (prefer-coding-system 'utf-8-unix)
  ))
(setenv "LANG" "ja_JP.UTF-8")


;; package
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; cl
(eval-when-compile (require 'cl))

;; @ load-path
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; load-pathに追加するフォルダ
;; 2つ以上フォルダを指定する場合の引数 => (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp" "elpa")

;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))


;;; --- バックアップとオートセーブ ---
;; バックアップファイルとオートセーブファイルを ~/.emacs.d/backups/ へ集める
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; 行番号を表示する
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#800"
                    :height 0.9)

;; 行番号フォーマット
(setq linum-format "%4d")

;;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;;; splash screenを無効にする
(setq inhibit-splash-screen t)

;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)

;; C-u C-SPC C-SPC ...でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)

;;; 複数のディレクトリで同じファイル名のファイルを開いたときのバッファ名を調整する
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;;; ファイルを開いた位置を保存する
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;;; ミニバッファ履歴を次回Emacs起動時にも保存する
(savehist-mode 1)

;;; モードラインに時刻を表示する
(display-time)

;;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;;; ログの記録行数を増やす
(setq message-log-max 10000)

;;; 履歴をたくさん保存する
(setq history-length 1000)

;;; メニューバーとツールバーとスクロールバーを消す
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;フォントをRictyにする
(set-face-font 'default "Ricty-15:nil")

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")
;; gothamテーマ
;; (load-theme 'gotham t)
(load-theme 'clues t)

;; 括弧の自動補完
(require 'smartparens)
(add-to-list 'sp-lisp-modes 'gauche-mode)
(require 'smartparens-config)
(smartparens-global-mode t)
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'slime-mode-hook 'enable-paredit-mode)
(add-hook 'inferior-scheme-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

;; ;; 括弧の範囲内を強調表示
(show-paren-mode t)
(setq show-paren-delay 0)

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format "%f")

;; タブ幅
(setq default-tab-width 2)

;; インデントにタブ文字を使用しない
(setq-default indent-tabs-mode nil)
                                        ; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; バックアップを残さない
(setq make-backup-files nil)

;; 行間
(setq-default line-spacing 0)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t)

;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.95))

;; モードラインに行番号表示
(line-number-mode t)

;; モードラインに列番号表示
(column-number-mode t)

;; C-RET で矩形選択
;; (cua-mode t)
;; (setq cua-enable-cua-keys nil)
;; (define-key global-map (kbd "C-x RET") 'cua-set-rectangle-mark)

;; ピープ音を鳴らさない
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))

;; C-k で行全体を削除（改行を含む）
;; (setq kill-whole-line t)

;; C-h を バックスペースへ
(keyboard-translate ?\C-h ?\C-?)

;; C-x ? を help へ
(global-set-key "\C-x?" 'help-command)

;; インタラクティブにウィンドウを分割する
(setq split-height-threshold nil)
(setq split-width-threshold 100)

;; C-t でウィンドウを切り替える。
(global-set-key "\C-t" 'other-window)

;; C-j で改行とインデント
(global-set-key "\C-j" 'newline-and-indent)

;; M-f,M-bの挙動を変更
;; (require 'misc)
;; (global-set-key (kbd "M-f") 'forward-to-word)
;; (global-set-key (kbd "M-b") 'backward-to-word)

;; C-a で行の先頭に。もう一度 C-aで文字の始まる位置に移動
(defun my-goto-line-beginning-or-indent (&optional $position)
  (interactive)
  (or $position (setq $position (point)))
  (let (($starting-position (progn (back-to-indentation) (point))))
    (if (eq $starting-position $position)
        (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'my-goto-line-beginning-or-indent)

;; indent-guide
;; (require 'indent-guide)
;; (indent-guide-global-mode)
;; (setq indent-guide-recursive t)

;; dired
;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)

(require 'dired-subtree)
;;; iを置き換え
(define-key dired-mode-map (kbd "i") 'dired-subtree-insert)
;;; org-modeのようにTABで折り畳む
(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-remove)
;;; C-x n nでsubtreeにナローイング
(define-key dired-mode-map (kbd "C-x n n") 'dired-subtree-narrow)

;;; ファイル名以外の情報を(と)で隠したり表示したり
(require 'dired-details)
(dired-details-install)
(setq dired-details-hidden-string "")
(setq dired-details-hide-link-targets nil)
(setq dired-details-initially-hide nil)

;;; dired-subtreeをdired-detailsに対応させる
(defun dired-subtree-after-insert-hook--dired-details ()
  (dired-details-delete-overlays)
  (dired-details-activate))
(add-hook 'dired-subtree-after-insert-hook
          'dired-subtree-after-insert-hook--dired-details)

;; find-dired対応
(defadvice find-dired-sentinel (after dired-details (proc state) activate)
  (ignore-errors
    (with-current-buffer (process-buffer proc)
      (dired-details-activate))))
;; (progn (ad-disable-advice 'find-dired-sentinel 'after 'dired-details) (ad-update 'find-dired-sentinel))

;;; [2014-12-30 Tue]^をdired-subtreeに対応させる
(defun dired-subtree-up-dwim (&optional arg)
  "subtreeの親ディレクトリに移動。そうでなければ親ディレクトリを開く(^の挙動)。"
  (interactive "p")
  (or (dired-subtree-up arg)
      (dired-up-directory)))
(define-key dired-mode-map (kbd "^") 'dired-subtree-up-dwim)

;; @ modeline

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

;; multi-term
(setq multi-term-program shell-file-name)

(global-set-key (kbd "C-c n") 'multi-term-next)
(global-set-key (kbd "C-c p") 'multi-term-prev)

(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-t") 'other-window)
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
            (define-key term-raw-map (kbd "M-d") 'term-send-forward-kill-word)
            (define-key term-raw-map (kbd "M-<backspace>") 'term-send-backward-kill-word)
            (define-key term-raw-map (kbd "M-DEL") 'term-send-backward-kill-word)
            (define-key term-raw-map (kbd "C-v") nil)
            (define-key term-raw-map (kbd "ESC ESC") 'term-send-raw)
            (define-key term-raw-map (kbd "C-q") 'toggle-term-view)))

(defun toggle-term-view () (interactive)
       (cond ((eq major-mode 'term-mode)
              (fundamental-mode)
              (view-mode-enable)
              (local-set-key (kbd "C-c C-c") 'toggle-term-view)
              (setq multi-term-cursor-point (point)))
             ((eq major-mode 'fundamental-mode)
              (view-mode-disable)
              (goto-char multi-term-cursor-point)
              (multi-term-internal))))

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)
(define-key ac-completing-map (kbd "M-n") 'ac-next)      ; C-nで次候補選択
(define-key ac-completing-map (kbd "M-p") 'ac-previous)  ; C-p で前候補選択
(ac-config-default)
(setq ac-fuzzy-enable t)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'inferior-scheme-mode)
(add-to-list 'ac-modes 'gauche-mode)
(add-to-list 'ac-modes 'kahua-mode)


(defvar ac-source-scheme
  '((candidates
     . (lambda ()
         (require 'scheme-complete)
         (all-completions ac-target (car (scheme-current-env))))))
  "Source for scheme keywords.")

;; (eval-after-load 'scheme
;;   '(progn
;;     (define-key scheme-mode-map "\e\t" 'scheme-smart-complete)
;;     (define-key scheme-mode-map "\t" 'scheme-complete-or-indent))
;;   )
(add-hook 'scheme-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (setq ac-sources (append ac-sources '(ac-source-scheme)))
            (setq default-scheme-implementation 'gauche)
            (setq *current-scheme-implementation* 'gauche)
            (set (make-local-variable 'eldoc-documentation-function)
                 'scheme-get-current-symbol-info)
            (eldoc-mode t)
            )
          )

(add-hook 'inferior-scheme-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (setq ac-sources (append ac-sources '(ac-source-scheme)))
            (setq default-scheme-implementation 'gauche)
            (setq *current-scheme-implementation* 'gauche)
            (set (make-local-variable 'eldoc-documentation-function)
                 'scheme-get-current-symbol-info)
            (eldoc-mode t)
            )
          )

;;; popwin
(require 'popwin)
(popwin-mode 1)
;; M-x anything
(setq helm-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)

;; M-x dired-jump-other-window
(push '(dired-mode :position top) popwin:special-display-config)

;; M-!
(push "*Shell Command Output*" popwin:special-display-config)

;; M-x compile
(push '(compilation-mode :noselect t) popwin:special-display-config)

;; slime
(push "*slime-apropos*" popwin:special-display-config)
(push "*slime-macroexpansion*" popwin:special-display-config)
(push "*slime-description*" popwin:special-display-config)
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
(push "*slime-xref*" popwin:special-display-config)
(push '(sldb-mode :stick t) popwin:special-display-config)
(push 'slime-repl-mode popwin:special-display-config)
(push 'slime-connection-list-mode popwin:special-display-config)

;; undo-tree
(push '(" *undo-tree*" :width 0.3 :position right) popwin:special-display-config)


;; migemo
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))	

;; Set your installed path
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8)
(load-library "migemo")
(migemo-init)

;; helm
(require 'helm-config)
(helm-mode 1)
;; ミニバッファでC-hをバックスペースに割り当て
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
;; C-iで補完
(define-key helm-read-file-map (kbd "C-i") 'helm-execute-persistent-action)
(when (require 'popwin)
  (setq helm-samewindow nil)
  (defvar display-buffer-function 'popwin:display-buffer)
  (setq popwin:special-display-config '(("*compilatoin*" :noselect t)
                                        ("helm" :regexp t :height 0.4)
                                        )))

(defvar helm-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")

(defvar helm-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Emacs commands history")

(custom-set-variables
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-files-in-current-dir
                               helm-source-emacs-commands-history
                               helm-source-emacs-commands
                               )))

(define-key global-map (kbd "C-;") 'helm-mini)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)


(require 'helm-migemo)
;;; この修正が必要
(eval-after-load "helm-migemo"
  '(defun helm-compile-source--candidates-in-buffer (source)
     (helm-aif (assoc 'candidates-in-buffer source)
         (append source
                 `((candidates
                    . ,(or (cdr it)
                           (lambda ()
                             ;; Do not use `source' because other plugins
                             ;; (such as helm-migemo) may change it
                             (helm-candidates-in-buffer (helm-get-current-source)))))
                   (volatile) (match identity)))
       source)))


(require 'helm-swoop)
;;; isearchからの連携を考えるとC-r/C-sにも割り当て推奨
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)

;;; 検索結果をcycle
(setq helm-swoop-move-to-line-cycle t)

(cl-defun helm-swoop-nomigemo (&key $query ($multiline current-prefix-arg))
  "シンボル検索用Migemo無効版helm-swoop"
  (interactive)
  (let ((helm-swoop-pre-input-function
         (lambda () (format "\\_<%s\\_> " (thing-at-point 'symbol)))))
    (helm-swoop :$source (delete '(migemo) (copy-sequence (helm-c-source-swoop)))
                :$query $query :$multiline $multiline)))
;;; C-M-:に割り当て
(global-set-key (kbd "C-M-:") 'helm-swoop-nomigemo)

;;; [2014-11-25 Tue]
(when (featurep 'helm-anything)
  (defadvice helm-resume (around helm-swoop-resume activate)
    "helm-anything-resumeで復元できないのでその場合に限定して無効化"
    ad-do-it))

;;; ace-isearch
(global-ace-isearch-mode 1)

;;; [2015-03-23 Mon]C-u C-s / C-u C-u C-s
(defun isearch-forward-or-helm-swoop (use-helm-swoop)
  (interactive "p")
  (let (current-prefix-arg
        (helm-swoop-pre-input-function 'ignore))
    (call-interactively
     (case use-helm-swoop
       (1 'isearch-forward)
       (4 'helm-swoop)
       (16 'helm-swoop-nomigemo)))))

(global-set-key (kbd "C-s") 'isearch-forward-or-helm-swoop)

;; git-gutter
(require 'git-gutter)

;; anzu
(global-anzu-mode +1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(custom-safe-themes
   (quote
    ("bdaab014ec6785f64b72efbea80808b762d8971247aacf2ffc6b76a39b9ed97c" default)))
 '(rspec-use-rake-when-possible nil)
 '(tab-width 2))

;;; emacs-lisp

;; emacs-lisp-mode-hook 用の関数を定義
(defun elisp-mode-hooks ()
  "Lisp-mode-hooks"
  (when (require 'eldoc nil t)
    (setq eldoc-idle-delay 0.2)
    (setq eldoc-echo-area-use-multiline-p t)
    (eldoc-mode)))

;; emacs-lisp-mode のフックをセットアップ
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

                                        ; カーソル位置のフェイス情報を表示
(defun my-get-face (&optional $point)
  (interactive)
  (or $point (setq $point (point)))
  (let (($face (or (get-char-property $point 'read-face-name)
                   (get-char-property $point 'face))))
    (if $face
        (message (format "%s" $face))
      (message "no face"))))

;;式の評価結果を注釈するための設定
(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

;; 自動コンパイル
(require 'auto-async-byte-compile)
;; 自動コンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-file-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idledeley 0.2)
(setq eldoc-minor-mode-string "")

;; scheme
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "gosh -i")
(add-to-list 'auto-mode-alist '("\\.scm" . scheme-mode))
;; (setq auto-mode-alist
;;      (cons '("\.\(scm\)$" . gauche-mode) auto-mode-alist))
;; (autoload 'gauche-mode "gauche-mode" "Major mode for Scheme." t)
;; (autoload 'run-scheme "gauche-mode" "Run an inferior Scheme process." t)
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window ()
  "Run Gauche on other window"
  (interactive)
  ;;(split-window-horizontally (/ (frame-width) 2))
  (let ((buf-name (buffer-name (current-buffer))))
    (scheme-mode)
    (switch-to-buffer-other-window
     (get-buffer-create "*scheme*"))
    (run-scheme scheme-program-name)
    (switch-to-buffer-other-window
     (get-buffer-create buf-name))))

(define-key global-map
  "\C-cg" 'scheme-other-window)

(defun my/gauche-info-index (topic)
  (interactive
   (list (read-string
          (concat "Gauche help topic : ")
          (current-word))))
  (switch-to-buffer-other-window (get-buffer-create "*info*"))
  (let ((info-file "/usr/share/info/gauche-refe.info.gz"))
    (info info-file)
    (Info-index topic)))
;; swank-gaucheを使うためのSLIME設定
;;
;;(push "<path-to-slime-dir>" load-path)
;; (require 'slime)
;; (slime-setup
;;  '(slime-fancy
;;    slime-scheme))

;; ;; swank-gauche.scmが格納されているディレクトリへのパスを設定して下さい。
;; (setq swank-gauche-path "/usr/local/Cellar/swank-gauche-master")

;; ;; Gaucheのソースを持っていて、かつ、コンパイル済の場合、ソースのトップ
;; ;; ディレクトリへのパスを設定して下さい。Gaucheのマニュアルに記載されている
;; ;; オペレータの引数名がルックアップ出来るようになります。
;; (setq swank-gauche-gauche-source-path "/usr/local/Cellar/gauche/Gauche")

;; (push swank-gauche-path load-path)
;; (require 'swank-gauche)

;; (setq slime-lisp-implementations
;;       '((gauche ("gosh") :init gauche-init :coding-system utf-8-unix)))

;; ;; バッファのモジュールを決定するための設定
;; (setq slime-find-buffer-package-function 'find-gauche-package)
;; ;; c-p-c補完に設定
;; (setq slime-complete-symbol-function 'slime-complete-symbol*)
;; ;; web上のGaucheリファレンスマニュアルを引く設定
;; (define-key slime-mode-map (kbd "C-c C-d H") 'gauche-ref-lookup)



(put 'and-let* 'scheme-indent-function 1)
(put 'begin0 'scheme-indent-function 0)
(put 'call-with-client-socket 'scheme-indent-function 1)
(put 'call-with-input-conversion 'scheme-indent-function 1)
(put 'call-with-input-file 'scheme-indent-function 1)
(put 'call-with-input-process 'scheme-indent-function 1)
(put 'call-with-input-string 'scheme-indent-function 1)
(put 'call-with-iterator 'scheme-indent-function 1)
(put 'call-with-output-conversion 'scheme-indent-function 1)
(put 'call-with-output-file 'scheme-indent-function 1)
(put 'call-with-output-string 'scheme-indent-function 0)
(put 'call-with-temporary-file 'scheme-indent-function 1)
(put 'call-with-values 'scheme-indent-function 1)
(put 'dolist 'scheme-indent-function 1)
(put 'dotimes 'scheme-indent-function 1)
(put 'if-match 'scheme-indent-function 2)
(put 'let*-values 'scheme-indent-function 1)
(put 'let-args 'scheme-indent-function 2)
(put 'let-keywords* 'scheme-indent-function 2)
(put 'let-match 'scheme-indent-function 2)
(put 'let-optionals* 'scheme-indent-function 2)
(put 'let-syntax 'scheme-indent-function 1)
(put 'let-values 'scheme-indent-function 1)
(put 'let/cc 'scheme-indent-function 1)
(put 'let1 'scheme-indent-function 2)
(put 'letrec-syntax 'scheme-indent-function 1)
(put 'make 'scheme-indent-function 1)
(put 'match 'scheme-indent-function 1)
(put 'match-lambda 'scheme-indent-function 1)
(put 'match-let 'scheme-indent-fucntion 1)
(put 'match-let* 'scheme-indent-fucntion 1)
(put 'match-letrec 'scheme-indent-fucntion 1)
(put 'match-let1 'scheme-indent-function 2)
(put 'match-define 'scheme-indent-fucntion 1)
(put 'multiple-value-bind 'scheme-indent-function 2)
(put 'parameterize 'scheme-indent-function 1)
(put 'parse-options 'scheme-indent-function 1)
(put 'receive 'scheme-indent-function 2)
(put 'rxmatch-case 'scheme-indent-function 1)
(put 'rxmatch-cond 'scheme-indent-function 0)
(put 'rxmatch-if  'scheme-indent-function 2)
(put 'rxmatch-let 'scheme-indent-function 2)
(put 'syntax-rules 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'until 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'while 'scheme-indent-function 1)
(put 'with-builder 'scheme-indent-function 1)
(put 'with-error-handler 'scheme-indent-function 0)
(put 'with-error-to-port 'scheme-indent-function 1)
(put 'with-input-conversion 'scheme-indent-function 1)
(put 'with-input-from-port 'scheme-indent-function 1)
(put 'with-input-from-process 'scheme-indent-function 1)
(put 'with-input-from-string 'scheme-indent-function 1)
(put 'with-iterator 'scheme-indent-function 1)
(put 'with-module 'scheme-indent-function 1)
(put 'with-output-conversion 'scheme-indent-function 1)
(put 'with-output-to-port 'scheme-indent-function 1)
(put 'with-output-to-process 'scheme-indent-function 1)
(put 'with-output-to-string 'scheme-indent-function 1)
(put 'with-port-locking 'scheme-indent-function 1)
(put 'with-string-io 'scheme-indent-function 1)
(put 'with-time-counter 'scheme-indent-function 1)
(put 'with-signal-handlers 'scheme-indent-function 1)
(put 'with-locking-mutex 'scheme-indent-funcion 1)
(put 'guard 'scheme-indent-function 1)

;;==========================================================
;;         web-modeの設定
;;==========================================================
(require 'web-mode)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-comment-style 2)
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
  (setq web-mode-enable-auto-pairing nil)
  )

(add-hook 'web-mode-hook  'my-web-mode-hook)

(defun sp-web-mode-is-code-context (id action context)
  (and (eq action 'insert)
       (not (or (get-text-property (point) 'part-side)
                (get-text-property (point) 'block-side)))))

(sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context))


(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

(setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev))))



;; 色の設定

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))


                                        ; ======================================================================


;; js2-mode
(require 'js2-mode)
(autoload 'js2-mode "js" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;; Common Lisp
(require 'slime)
;; (load (expand-file-name "~/.roswell/impls/ALL/ALL/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "ros -L sbcl -Q run")
(slime-setup '(slime-repl slime-fancy slime-banner slime-indentation))
(setq slime-net-coding-system 'utf-8-unix)

;;; ac-slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)


;; open-jnkfile
(require 'open-junk-file)
(setq open-junk-file-format "~/Documents/junk/%Y-%m%d-%H%M%S.")
(global-set-key "\C-xj" 'open-junk-file)

;; org
(require 'org)
(require 'ob-scheme)
(require 'ob-ruby)

(setq org-directory "~/Documents/junk")
(setq org-agenda-files (list org-directory))

(setq org-src-fontify-natively t)

(defun my-org-confirm-babel-evaluate (lang body)
  (not (or (string= lang "scheme")
           (string= lang "emacs-lisp")
           (string= lang "ruby")
           (string= lang "C")
           (string= lang "cpp")
           )))

(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
(global-set-key (kbd "C-c l")
                'org-store-link)

(require 'flycheck)

(flycheck-define-checker c/c++
  "A C/C++ checker using g++."
  :command ("g++" "-Wall" "-Wextra" source)
  :error-patterns  ((error line-start
                           (file-name) ":" line ":" column ":" " エラー: " (message)
                           line-end)
                    (warning line-start
                             (file-name) ":" line ":" column ":" " 警告: " (message)
                             line-end))
  :modes (c-mode c++-mode))

;;; C
(require 'cc-mode)

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-default-style "linux")
            (setq indent-tabs-mode t)
            (setq c-basic-offset 2)
            'flycheck-mode
            (setq c-auto-newline t)
            ))


;;; Ocaml
;;; tuareg
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
;;(setq tuareg-use-smie nil)

;;; merlin
(require 'merlin)
;; (push "<SHARE_DIR>/emacs/site-lisp" load-path) ; directory containing merlin.el
(setq merlin-command "~/.opam/system/bin/ocamlmerlin")
(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook 'merlin-mode)
;; (setq merlin-ac-setup 'easy)
(add-hook 'merlin-mode-hook
          (lambda ()
            (setq ac-sources (append ac-sources '(merlin-ac-source)))))



;;; flycheck OCaml
(with-eval-after-load 'merlin
  ;; Disable Merlin's own error checking
  (setq merlin-error-after-save nil)

  ;; Enable Flycheck checker
  (flycheck-ocaml-setup))


;;; Ruby
(setq ruby-insert-encoding-magic-comment nil)
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode)) ;; shebangがrubyの場合、ruby-modeを開く


;; ;; ruby-modeのインデントを改良する
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; ;;ruby-end
;; (ruby-end-mode nil)
;; (require 'ruby-end)
;; (add-hook 'ruby-mode-hook
;;   '(lambda ()
;;      (abbrev-mode 1)
;;      (electric-indent-mode t)
;;      (electric-layout-mode t)))

(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)


;; ;;; robe
(add-hook 'ruby-mode-hook 'robe-mode)
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(add-hook 'robe-mode-hook 'ac-robe-setup)

;; ;;rbenv
;; (require 'rbenv)
;; (global-rbenv-mode)
;; (setq rbenv-installation-dir "/usr/local/Cellar/rbenv/1.0.0")
;; (setq rbenv-show-active-ruby-in-modeline -1)

 ;; C-c , v RSpec実行
 ;; C-c , s カ-ソルが当たっているサンプルを実行
 ;; C-c , t Specとソースを切り替える
;; (require 'rspec-mode)

;; ;; inf-rubyでpryを使う
(require 'inf-ruby)
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-eval-binding "Pry.toplevel_binding")
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

;; ;; (setq inf-ruby-default-implementation "pry")
;; ;; (setq inf-ruby-eval-binding "Pry.toplevel_binding")
;; ;; (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

;; ;; rcodetools
(require 'rcodetools)
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map (kbd "<C-tab>") 'rct-complete-symbol)
  (define-key ruby-mode-map (kbd "C-c d") 'xmp))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)
(defun make-ruby-scratch-buffer ()
  (with-current-buffer (get-buffer-create "*ruby scratch*")
    (ruby-mode)
    (current-buffer)))
(defun ruby-scratch ()
  (interactive)
  (pop-to-buffer (make-ruby-scratch-buffer)))

;;; キーボードマクロ
(fset 'endspace
      "\C-e  \C-n")

(fset 'next-eval
      "\C-\M-e\C-x\C-e")

