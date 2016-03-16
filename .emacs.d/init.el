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
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq use-dialog-box nil)
(setenv "LANG" "ja_JP.UTF-8")

;;; Packages:
(when (or (require 'cask "~/.cask/cask.el" t)
	  (require 'cask nil t))
  (cask-initialize))
(package-initialize)

(require 'use-package)
(pallet-mode t)

;; nyan-mode
(custom-set-variables '(nyan-bar-length 16))
(nyan-mode t)

;;; color-theme
(load-theme 'gotham t)


;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")

;; PATH
(exec-path-from-shell-initialize)

(let ((default-directory (locate-user-emacs-file "./elisp")))
  (add-to-list 'load-path default-directory)
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


(progn
  (bind-key "C-?"    'help-command)
  (bind-key "C-t"   'other-window)
  (bind-key "C-j"    'newline-and-indent)
  (bind-key "C-S-n" 'make-frame)
  (bind-key "C-S-w" 'delete-frame)
  (bind-key "C-M-y" 'helm-show-kill-ring)
  (bind-key "C-c n" 'multi-term-next))

(keyboard-translate ?\C-h ?\C-?)

;; exchange meta-key to super-key
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier 'super)

(custom-set-variables
 '(key-chord-two-keys-delay 0.02))
(key-chord-mode t)
(key-chord-define-global "df" 'find-function)
(key-chord-define-global "fh" 'describe-function)
(key-chord-define-global "fv" 'find-variable)
(key-chord-define-global "pi" 'package-install)
(key-chord-define-global "kl" 'align-regexp)

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
  :diminish flycheck-mode
  :init
  (global-flycheck-mode t)
  :config
  ;; (flycheck-package-setup)
  )

;; Smartparens
(use-package smartparens
  :diminish smartparens-mode)
(require 'smartparens-config)
(smartparens-global-mode t)

;; which-fund
(which-function-mode t)

(use-package popwin)

;;; Language

(custom-set-variables
 '(sql-product 'mysql))

;; Web
(defun my/web-mode-hook ()
  "Set variables for web-mode."
  (custom-set-variables
   '(web-mode-enable-auto-pairing nil)))

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
  (--each '("\\.html?\\'" "\\.tpl\\'" "\\.tpl\\.xhtml\\'" "\\.ejs\\'" "\\.hbs\\'" "\\.html\\.erb\\'")
    (add-to-list 'auto-mode-alist (cons it 'web-mode)))
  :config
  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context)))

(add-to-list 'auto-mode-alist '("/Gemfile.lock\\'" . conf-mode))

(use-package ruby-mode
  :config
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (setq flycheck-checker 'ruby-rubocop)
               (flycheck-mode 1)))
  (use-package ruby-electric-mode :defer t
    :config
    (ruby-electric-mode t))
  (use-package ruby-block
    :config
    (ruby-block-mode t))
  (use-package rcodetools
    :config
    (bind-key "C-c d" 'xmp ruby-mode-map)))

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
                           (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
                           line-end)
                  (error line-start
                         (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
                         line-end)))
               (setq flycheck-checker 'ruby-rubocop)
               (ruby-electric-mode t)
               (ruby-block-mode t)
               (setq ruby-block-highlight-toggle t)
               (flycheck-mode 1))))

(magic-filetype-set-auto-mode 'ruby)

;; inf-ruby
(use-package inf-ruby :defer t
  :config
  (custom-set-variables
   '(inf-ruby-default-implementation "pry")
   '(inf-ruby-eval-binding "Pry.toplevel_binding"))
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on))

;; robe
;; (add-hook 'ruby-mode-hook 'robe-mode)
;; (autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
;; (autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
;; (add-hook 'robe-mode-hook 'ac-robe-setup)

(use-package robe
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  :config
  (add-hook 'robe-mode-hook 'ac-robe-setup))


;; Lisp
(defvar my/emacs-lisp-ac-sources
  '(ac-source-features ac-source-functions ac-source-variables ac-source-symbols))

(defun my/emacs-lisp-mode-hook ()
  ""
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
  (--each my/emacs-lisp-modes (add-hook it 'enable-paredit-mode))
  :config
  (bind-keys :map paredit-mode-map
             ("C-<right>" . 'right-word)
             ("C-<left>"  . 'left-word)))

;; Common Lisp
;; slime
(use-package slime :defer t
  :config
  ;;(setq display-buffer-function 'popwin:display-buffer)
  (when (fboundp 'popwin:w3m-browse-url)
    (setq browse-url-browser-function 'popwin:w3m-browse-url))
  (setq popwin:special-display-config
        (append popwin:special-display-config
                '(("*anything for files*")
                  ("*anything find-file*")
                  ("*anything moccur*")
                  ("*anything complete*")
                  ("*anything*")
                  ("*w3m*")
                  ("*slime-apropos*")
                  ("*slime-macroexpansion*")
                  ("*slime-description*")
                  ("*slime-compilation*" :noselect t)
                  ("*slime-xref*")
                  (slime-connection-list-mode)
                  (sldb-mode :height 20 :stick t)
                  (direx:direx-mode :position left :width 25 :dedicated t)
                  ("*quickrun*")))))

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
(use-package ac-slime :defer t
  :init
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac))


;; JavaScript
(use-package js2-mode :defer t
  :mode "\\.js\\'")


;; CoffeeScript
(use-package coffee :defer t
  :config
  (setq-default coffee-tab-width 2)
  (defun my/coffee-hook ()
    (set (make-local-variable 'tab-width) 2))
  (add-hook 'coffee-mode 'my/coffee-hook))

;; Markdown Mode
(use-package markdown-mode :defer t
  :mode ("\\.md\\'" . gfm-mode)
  :config
  ;;(unbind-key "`" markdown-mode-map)
  (visual-line-mode nil))

;; Emmet-mode
(use-package emmet-mode :defer t
  :init
  (add-hook 'web-mode-hook  'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode))


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
  (bind-key "C-_" #'undo-tree-undo)
  (bind-key "C-?" #'undo-tree-redo))

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
   '(open-junk-file-format "~/Document/junk/%Y/%m/%Y-%m-%d-%H%M%S."))
  (bind-key "C-x j" 'open-junk-file))

;; ElScreen
(use-package elscreen
  :init
  (custom-set-variables
   '(elscreen-prefix-key (kbd "C-z"))
   '(elscreen-tab-display-kill-screen nil)
   '(elscreen-tab-display-control nil))
  ;;(bind-key "C-t p" 'helm-elscreen)
  (bind-key* "C-<tab>" 'elscreen-next)
  (bind-key* "<C-iso-lefttab>" 'elscreen-previous)
  (elscreen-start))

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
    '(("C-." . 'mc/mark-next-like-this)
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






;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)


;; C-a で行の先頭に。もう一度 C-aで文字の始まる位置に移動
(defun my-goto-line-beginning-or-indent (&optional $position)
  (interactive)
  (or $position (setq $position (point)))
  (let (($starting-position (progn (back-to-indentation) (point))))
    (if (eq $starting-position $position)
      (move-beginning-of-line 1))))

(bind-key "C-a" 'my-goto-line-beginning-or-indent)


;; Beacon — Never lose your cursor again
(beacon-mode 1)

;;; init.el ends here
