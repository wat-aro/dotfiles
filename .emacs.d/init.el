;;; Package: --- Sammary
;;; Commentary:
;;; Code:
;;; GC
(setq-default gc-cons-percentage 0.5)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;;; Variables
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
;;(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq use-dialog-box nil)
(setenv "LANG" "ja_JP.UTF-8")

(set-face-font 'default "Ricty-15:nil")

;;; Packages:
(when (or (require 'cask "~/.cask/cask.el" t)
	  (require 'cask nil t))
  (cask-initialize))
(package-initialize)

(require 'use-package)
(pallet-mode t)

;; ;;; skk
;; (when (require 'skk nil t)
;;   (global-set-key "\C-\\" 'skk-mode)
;;   (setq default-input-method "japanese-skk")
;;   (require 'skk-study))

;; (require 'sticky)
;; (use-sticky-key ?\; sticky-alist:ja)

;;; color-theme
;; (load-theme 'flatland t)
;; (load-theme 'hamburg t)
(load-theme 'clues t)
;; (load-theme 'gotham t)
;; (load-theme 'vsc t)

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")

;; PATH
(exec-path-from-shell-initialize)

(let ((default-directory (locate-user-emacs-file "./elisp"))
      (opam-directory "~/.opam/system/share/emacs/site-lisp"))
  (add-to-list 'load-path default-directory)
  (add-to-list 'load-path opam-directory)
  (normal-top-level-add-subdirs-to-load-path))

;; (load-file (expand-file-name "~/.emacs.d/shellenv.el"))
;; (dolist (path (reverse (split-string (getenv "PATH") ":")))
;;   (add-to-list 'exec-path path))

;;; Coding:
(setq-default indent-tabs-mode nil)

;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.90))

;; ピープ音を鳴らさない
(setq visible-bell t)
(setq ring-bell-function 'ignore)


;; White space
(setq-default show-trailing-whitespace t)

;; Uniquify
(custom-set-variables '(uniquify-buffer-name-style 'post-forward-angle-brackets))

;; Show paren
(show-paren-mode t)

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

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format "%f")

;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)

;; C-u C-SPC C-SPC ...でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)

; yes or noをy or n
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

;; anzu
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(custom-safe-themes
   (quote
    ("bdaab014ec6785f64b72efbea80808b762d8971247aacf2ffc6b76a39b9ed97c" default)))
 '(rspec-use-rake-when-possible nil)
 '(tab-width 2))

;; インタラクティブにウィンドウを分割
(setq split-height-threshold nil)
(setq split-width-threshold 150)

;; volatile-highlights.el
(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :init
  (volatile-highlights-mode t))

;; Rainbow mode
(use-package rainbow-mode
  :defer t
  :diminish rainbow-mode)

;;; --- バックアップとオートセーブ ---
;; バックアップファイルとオートセーブファイルを ~/.emacs.d/backups/ へ集める
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))
(setq create-lockfiles nil)


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

;; (custom-set-variables
;;  '(key-chord-two-keys-delay 0.01))
;; (key-chord-mode t)
;; (key-chord-define-global "df" 'find-function)
;; (key-chord-define-global "fh" 'describe-function)
;; (key-chord-define-global "fv" 'find-variable)
;; (key-chord-define-global "pk" 'package-install)
;; (key-chord-define-global "kl" 'align-regexp)
;; (key-chord-define-global "dv" 'describe-variable)

;; Helm
(use-package helm :defer t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (bind-key "C-x C-f" 'helm-find-files)
  (bind-key "M-x" 'helm-M-x)
  (bind-key "C-;" 'helm-mini)
  (helm-mode t)
  :config
  (bind-keys :map helm-map
              ("C-i" . helm-execute-persistent-action)
              ("C-h" . delete-backward-char)))

(add-to-list 'helm-for-files-preferred-list 'helm-source-ghq)
(add-to-list 'exec-path "/home/wat-aro/golang/bin")
(define-key global-map (kbd "C-x f")     'helm-ghq)

;; Helm-ag
(custom-set-variables '(helm-ff-file-compressed-list '("epub" "gz" "bz2" "zip" "7z")))
(bind-key "C-:" 'helm-ag)

;; Auto-Complete
(use-package auto-complete
  :diminish auto-complete-mode
  :config
  (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "./ac-dict"))
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  (bind-key "M-n" 'ac-next)
  (bind-key "M-p" 'ac-previous)
  (setq ac-auto-show-menu 0.5)
  (setq ac-menu-height 20)
  (setq ac-use-fuzzy t)
  (robe-mode))


;; Magit
;; (use-package magit :defer t)
(setq-default magit-auto-revert-mode nil)
(setq vc-handled-backends '())
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))
(bind-key "C-x m" 'magit-status)
(bind-key "C-c l" 'magit-blame)

;; (use-package magit-find-file :defer t)
(bind-key "M-t" 'magit-find-file-completing-read)

(add-to-list 'auto-mode-alist '("/\\.gitexclude\\'" . gitignore-mode))

;; Conf-Mode
(require 'generic-x)
(add-to-list 'auto-mode-alist '("/\\.*conf\\(ig\\)?\\'" . conf-mode) t)
(add-to-list 'auto-mode-alist '("/\\.*rc\\'" . conf-mode) t)

;; Projectile
(use-package projectile :defer t
  :config
  (use-package helm-projectile)
  (custom-set-variables
   '(projectile-completion-system 'helm))
  (projectile-global-mode t)
  (helm-projectile-on)
  (add-hook 'projectile-mode-hook 'projectile-rails-on))

;; Flycheck
(use-package flycheck
  :ensure t)

;; Smartparens
(use-package smartparens
  :diminish
  smartparens-mode
  :init
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (sp-pair "<%" " %>"))



;; which-fund
(which-function-mode t)

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

;;; Language

(custom-set-variables
 '(sql-product 'mysql))

;; Web
(defun my/web-mode-hook ()
  "Set variables for web-mode."
  (custom-set-variables
   '(web-mode-enable-auto-pairing nil))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-comment-style 2)
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t))

(defun sp-web-mode-is-code-context  (id action context)
  "This snippet is derived from http://web-mode.org/ ."
  (when (and (eq action 'insert)
             (not (or (get-text-property (point) 'part-side)
                      (get-text-property (point) 'block-side))))
    t))

(use-package web-mode :defer t
  :init
  (add-hook 'web-mode-hook 'my/web-mode-hook)
  (add-hook 'web-mode-hook 'emmet-mode)
  (--each '("\\.html?\\'" "\\.tpl\\'" "\\.tpl\\.xhtml\\'" "\\.ejs\\'" "\\.hbs\\'"
            "\\.html\\.erb\\'" "\\.html\\+smartphone\\.erb\\'" "\\.html\\.slim\\'" "\\.css?\\'"
            "\\.js\\.coffee\\.erb\\'" "\\.js\\.erb\\'")
    (add-to-list 'auto-mode-alist (cons it 'web-mode)))
  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context))
  :config
  (setq web-mode-markup-indent-offset 2)
  (flycheck-mode t))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'html-tidy 'web-mode)
  (flycheck-add-mode 'css-csslint 'web-mode))

(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

;; インデント幅を2にする
;; コンパイルは compass watchで行うので自動コンパイルをオフ
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
  '(lambda() (scss-custom)))

(add-to-list 'auto-mode-alist '("/Gemfile.lock\\'" . conf-mode))

(use-package ruby-mode
  :interpreter (("ruby" . ruby-mode))
  :config
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (setq flycheck-checker 'ruby-rubocop)
               (flycheck-mode 1)
               (setq ruby-deep-indent-paren nil)))
    (use-package ruby-block
      :config
      (ruby-block-mode t))
    ;; (use-package ruby-electric
    ;;   :config
    ;;   (ruby-electric-mode t)
  (use-package rcodetools
    :config
    (bind-key "C-c d" 'xmp ruby-mode-map)
    (flycheck-mode t)))

;; (use-package ruby-electric
;;   :defer t
;;   :commands ruby-electric-mode
;;   :init
;;   (progn
;;     (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t))))
;;   :config
;;   (progn
;;     (setq ruby-electric-expand-delimiters-list nil)))
(setq ruby-deep-indent-paren nil)
(use-package rubocop
  :init
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (rubocop-mode t)
               (flycheck-define-checker ruby-rubocop
                 "A Ruby syntax and style checker using the RuboCop tool."
                 :command ("rubocop" "--format" "emacs"
                           (config-file "--config" flycheck-rubocoprc)
                           source)
                 :error-patterns
                 ((warning line-start
                           (file-name) ":" line ":" column ": " (or "C" "W") ": " (messae)
                           line-end)
                  (error line-start
                         (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
                         line-end)))
               (setq flycheck-checker 'ruby-rubocop)
               (setq ruby-block-highlight-toggle t)
               (flycheck-mode 1))))

;; (magic-filetype-set-auto-mode 'ruby)
(setq ruby-insert-encoding-magic-comment nil)

;; inf-ruby
(use-package inf-ruby :defer t
  :init
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
  :config
  (custom-set-variables
   '(inf-ruby-default-implementation "pry")
   '(inf-ruby-eval-binding "Pry.toplevel_binding")))


;; robe
;; (autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(use-package robe :defer t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-hook 'robe-mode-hook 'ac-robe-setup))

(use-package ac-robe-setup :defer t
  :commands (ac-robe-setup))

;;; helm-gtags
(add-hook 'helm-gtags-mode-hook
'(lambda ()
;;入力されたタグの定義元へジャンプ
(local-set-key (kbd "M-t") 'helm-gtags-find-tag)
;;入力タグを参照する場所へジャンプ
(local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
;;入力したシンボルを参照する場所へジャンプ
(local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
;;タグ一覧からタグを選択し, その定義元にジャンプする
(local-set-key (kbd "M-l") 'helm-gtags-select)
;;ジャンプ前の場所に戻る
(local-set-key (kbd "M-j") 'helm-gtags-pop-stack)))
(add-hook 'php-mode-hook 'helm-gtags-mode)
(add-hook 'ruby-mode-hook 'helm-gtags-mode)

;; Lisp
(defvar my/emacs-lisp-ac-sources
  '(ac-source-features ac-source-functions ac-source-variables ac-source-symbols))

(defun my/emacs-lisp-mode-hook ()
  "My Emacs Lisp mode."
  (rainbow-mode t)
  (auto-complete-mode 1)
  (setq ac-sources (append ac-sources my/emacs-lisp-ac-sources))
  (set-face-foreground 'font-lock-regexp-grouping-backslash "indian red")
  (set-face-foreground 'font-lock-regexp-grouping-construct "peru"))

(defvar my/emacs-lisp-modes
  '(emacs-lisp-mode-hook lisp-interaction-mode-hook ielm-mode-hook))
(--each my/emacs-lisp-modes
  (add-hook it 'turn-on-eldoc-mode)
  (add-hook it 'elisp-slime-nav-mode)
  (add-hook it 'my/emacs-lisp-mode-hook))

;; `Cask' is NOT emacs-lisp-mode
(add-to-list 'auto-mode-alist '("/Cask\\'" . lisp-mode))

(use-package paredit :defer t
  :diminish paredit-mode
  :init
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-mode-hook 'enable-paredit-mode)
  (add-hook 'inferior-scheme-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  :config
  (bind-keys :map paredit-mode-map
             ("C-<right>" . 'right-word)
             ("C-<left>"  . 'left-word)))

;; Common Lisp
;; slime
;; (use-package slime :defer t
;;   :init
;;   (setq inferior-lisp-program "ros -L sbcl -Q run")
;;   (load (expand-file-name "~/.roswell/impls/ALL/ALL/quicklisp/slime-helper.el"))
;;   (setq inferior-lisp-program "ros -L sbcl -Q run")
;;   (setf slime-lisp-implementations
;;         `((sbcl    ("sbcl" "--dynamic-space-size" "2000"))
;;           (roswell ("ros" "dynamic-space-size=2000" "-Q" "-l" "~/.sbclrc" "run"))))
;;   (setf slime-default-lisp 'roswell)
;;   :config
;;   ;; (setq display-buffer-function 'popwin:display-buffer)
;;   )

;; Scheme
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(defvar scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window ()
  "Run Gauche on other window."
  (interactive)
  (split-window-horizontally (/ (frame-width) 2))
  (let ((buf-name (buffer-name (current-buffer))))
    (scheme-mode)
    (switch-to-buffer-other-window
     (get-buffer-create "*scheme*"))
    (run-scheme scheme-program-name)
    (switch-to-buffer-other-window
     (get-buffer-create buf-name))))

(bind-key "C-c g" 'scheme-other-window)

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


;; ac-slime
;; (use-package ac-slime :defer t
;;   :init
;;   (add-hook 'slime-mode-hook 'set-up-slime-ac)
;;   (add-hook 'slime-repl-mode-hook 'set-up-slime-ac))


;; ;; JavaScript
;; (defun js2-mode-hooks ()
;;   (font-lock-add-keywords nil
;;                           '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))

;;   (defun underscore-require ()
;;     (interactive)
;;     (insert (format "var _ = require('underscore');"))
;;     )
;;   (local-set-key (kbd "C-x c j") 'underscore-require))

;; (use-package js2-mode
;;   :mode "\\.js\\'"
;;   :init
;;   (add-hook 'js2-mode-hook 'js2-mode-hooks)
;;   (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;;   :config
;;   (custom-set-variables '(js2-basic-offset 2)))

;; (use-package turn
;;   :config
;;   (use-package tern-auto-complete)
;;   (tern-ac-setup))

(use-package js2-mode
  :init
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  :mode "\\.js\\'" "\\.json\\'"
  :config
  (custom-set-variables '(js2-basic-offset 2))
  (bind-keys :map js2-mode-map
             ("C-c C-e" . nodejs-repl-send-last-sexp)
             ("C-c C-l" . nodejs-repl-load-file)
             ("C-c C-b" . nodejs-repl-send-buffer)
             ("C-c C-g" . nodejs-repl-send-region)))
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\.js$" . js2-mode))
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (tern-mode t)))
;; (custom-set-variables '(js2-basic-offset 2))

(add-to-list 'auto-mode-alist '( "\\.jsx\\'" . js2-jsx-mode))
;; (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
;; (add-hook 'js2-jsx-mode-hook 'flycheck-mode)

(use-package tern
  :config
  (use-package tern-auto-complete)
  (tern-ac-setup))

;; (eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

(use-package coffee-mode :defer t
  :mode "\\.js\\.coffee\\'"
  :config
  (custom-set-variables '(coffee-tab-width 2))
  (flycheck-mode t))

(use-package nodejs-repl
  :init
  (add-hook 'js2-mode-hook (lambda () (tern-mode t))))


;; CoffeeScript
;; (use-package coffee :defer t
;;   :config
;;   (setq-default coffee-tab-width 2)
;;   (defun my/coffee-hook ()
;;     (set (make-local-variable 'tab-width) 2))
;;   (add-hook 'coffee-mode 'my/coffee-hook))


;;; Ocaml
;;; tuareg
;; (add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
;; (autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
;; (autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
;; (autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
;;(setq tuareg-use-smie nil)

;; ;;; merlin
;; ;; Add opam emacs directory to the load-path
;; (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
;; ;; Load merlin-mode
;; (require 'merlin)
;; ;; (push "<SHARE_DIR>/emacs/site-lisp" load-path) ; directory containing merlin.el
;; (autoload 'merlin-mode "merlin" "Merlin mode" t)
;; ;; Start merlin on ocaml files
;; (add-hook 'tuareg-mode-hook 'merlin-mode t)
;; (add-hook 'caml-mode-hook 'merlin-mode t)
;; ;; Enable auto-complete
;; (add-hook 'merlin-mode-hook
;;           (lambda ()
;;             (setq ac-sources (append ac-sources '(merlin-ac-source)))))
;; ;; Use opam switch to lookup ocamlmerlin binary
;; (setq merlin-command 'opam)


;;; Elixir
(require 'elixir-mode)
(require 'alchemist)
(require 'flycheck-elixir)
(add-to-list 'elixir-mode-hook
             (defun auto-activate-ruby-end-mode-for-elixir-mode ()
               (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
                    "\\(?:^\\|\\s-+\\)\\(?:do\\)")
               (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
               (ruby-end-mode +1)

               (ac-alchemist-setup)
               ))

;; ;;; flycheck OCaml
;; (with-eval-after-load 'merlin
;;   ;; Disable Merlin's own error checking
;;   (setq merlin-error-after-save nil)
;;   ;; Enable Flycheck checker
;;   (flycheck-ocaml-setup))

;; Markdown Mode
(use-package markdown-mode :defer t
  :mode ("\\.md\\'" . gfm-mode)
  :config
  ;;(unbind-key "`" markdown-mode-map)
  (visual-line-mode nil))

;; (require 'w3m)
;; (define-key markdown-mode-map "\C-c\C-cm"
;;   (lambda ()
;;     (interactive)
;;     (w3m-find-file (buffer-file-name))))

;; Emmet-mode
(use-package emmet-mode :defer t
  :init
  (add-hook 'web-mode-hook  'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  :config
  (bind-key "C-c j" 'emmet-expand-line emmet-mode-keymap)
  (bind-key "C-j" nil emmet-mode-keymap))

(use-package slim-mode
  :mode
  ("\\.slim\\'" . slim-mode)
  ("\\.html\\.slim\\'" . slim-mode))

(use-package haml-mode
  :mode
  ("\\.haml\\'" . haml-mode)
  ("\\.html\\.haml\\'" . haml-mode))

;;; Others

;; Recentf
(use-package recentf-ext
  :init
  (custom-set-variables
   '(recentf-max-saved-items 2000)
   '(recentf-auto-cleanup 100)
   '(recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores"))
   (list 'recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list)))
  (recentf-mode t)
  (bind-key "C-c t" 'helm-recentf))

;; Undo Tree
(use-package undo-tree
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode)
  (bind-key "C-/" #'undo-tree-undo)
  (bind-key "C-'" #'undo-tree-redo))

;; expand-region.el
(use-package expand-region :defer t
  :init
  (bind-key "C-@" 'er/expand-region)
  (bind-key "C-`" 'er/contract-region))

;; Annotate.el
(use-package annotate :defer t
  :init
  (bind-key "M-@"   'annotate-annotate)
  (bind-key "C-M-@" 'annotate-clear-annotations))

;;; Tools:

;; Open junk file
(use-package open-junk-file
  :init
  (custom-set-variables
   '(open-junk-file-format "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S."))
  (bind-key "C-x j" 'open-junk-file))

;; org
(use-package org
  :config
  (use-package ob-ruby)
  (setq org-directory "~/Documents/junk")
  (setq org-agenda-files (list org-directory))

  (setq org-src-fontify-natively t)

  (defun my-org-confirm-babel-evaluate (lang body)
    (not (or (string= lang "ditaa")
             (string= lang "emacs-lisp")
             (string= lang "ruby")
             (string= lang "C")
             (string= lang "cpp")
             )))
  (setq org-hide-leading-stars t)
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate))

;; ElScreen
;; (use-package elscreen
;;   :init
;;   (custom-set-variables
;;    '(elscreen-prefix-key (kbd "C-z"))
;;    '(elscreen-tab-display-kill-screen nil)
;;    '(elscreen-tab-display-control nil))
;;   ;;(bind-key "C-t p" 'helm-elscreen)
;;   (bind-key* "C-<tab>" 'elscreen-next)
;;   (bind-key* "<C-iso-lefttab>" 'elscreen-previous)
;;   (elscreen-start))

;; Swoop
(use-package helm-swoop
  :init
  (setq helm-swoop-move-to-line-cycle t)
  (bind-key "M-C-;" 'helm-swoop)
;;  (bind-key "C-;" 'helm-multi-swoop)
  :config
  (bind-key "C-r" 'helm-previous-line helm-swoop-map)
  (bind-key "C-s" 'helm-next-line helm-swoop-map))

;; direx
(use-package direx :defer t
  :init
  (bind-key "M-C-\\" 'direx-project:jump-to-project-root-other-window))

;; dired-k
(use-package dired-k :defer t
  :init
  (add-hook 'dired-initial-position-hook 'dired-k)
  (bind-key "K" 'dired-k dired-mode-map))

;; Visual
(bind-key "M-%" 'vr/query-replace)

;; image-mode
(use-package image-mode :defer t
  :config
  (bind-key "<wheel-up>"    'image-previous-line    image-mode-map)
  (bind-key "<wheel-down>"  'image-next-line        image-mode-map)
  (bind-key "<wheel-right>" 'image-forward-hscroll  image-mode-map)
  (bind-key "<wheel-left>"  'image-backward-hscroll image-mode-map))

;; multiple-cursors
;; http://qiita.com/ongaeshi/items/3521b814aa4bf162181d
(use-package multiple-cursors
  :init
  (require 'smartrep)
  (declare-function smartrep-define-key "smartrep")
  (bind-key "C-M-c" 'mc/edit-lines)
  (bind-key "C-M-r" 'mc/mark-all-in-region)
  (global-unset-key (kbd "C-."))
  (smartrep-define-key global-map "C-."
    '(("C-'" . 'mc/mark-next-like-this)
      ("n"   . 'mc/mark-next-like-this)
      ("p"   . 'mc/mark-previous-like-this)
      ("m"   . 'mc/mark-more-like-this-extended)
      ("u"   . 'mc/unmark-next-like-this)
      ("U"   . 'mc/unmark-previous-like-this)
      ("s"   . 'mc/skip-to-next-like-this)
      ("S"   . 'mc/skip-to-previous-like-this)
      ("*"   . 'mc/mark-all-like-this)
      ("d"   . 'mc/mark-all-like-this-dwim)
      ("i"   . 'mc/insert-numbers)
      ("o"   . 'mc/sort-regions)
      ("O"   . 'mc/reverse-regions))))

;; which-key
(use-package which-key
  :diminish which-key-mode
  :init
  (which-key-setup-side-window-right-bottom)
  (which-key-mode t))

(use-package ag-mode :defer t
  :init
  (add-hook 'ag-mode-hook '(lambda ()
                             (use-package wgrep-ag)
                             (setq wgrep-auto-save-buffer t)  ; 編集完了と同時に保存
                             (setq wgrep-enable-key "r")      ; "r" キーで編集モードに
                             (wgrep-ag-setup)))
  :config
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers t)
  (use-package wgrep-ag)
  (setq wgrep-auto-save-buffer t)
  (setq wgrep-enable-key "r")
  (wgrep-ag-setup))

;; 自動でバッファの再読み込み
(global-auto-revert-mode 1)

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

"Add an optionally FUZZY slime completion source to `ac-sources'."
;; C-a で行の先頭に。もう一度 C-aで文字の始まる位置に移動
(defun my-goto-line-beginning-or-indent (&optional $position)
  "Go to POSITION, if add optionally."
  (interactive)
  (or $position (setq $position (point)))
  (let (($starting-position (progn (back-to-indentation) (point))))
    (if (eq $starting-position $position)
      (move-beginning-of-line 1))))

(bind-key "C-a" 'my-goto-line-beginning-or-indent)

;; Beacon — Never lose your cursor again
(beacon-mode 1)

;; nyan-mode
;; (custom-set-variables '(nyan-bar-length 16))
;; (nyan-mode t)

(defun sicp ()
  (interactive)
  (info "~/.emacs.d/info/sicp.info"))

(defun onlisp ()
  (interactive)
  (info "~/.emacs.d/info/onlisp.info"))


;;; init.el ends here
