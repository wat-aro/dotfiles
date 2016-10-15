(package-initialize)

(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)
(use-package "pallet")
(pallet-mode t)

(init-loader-load "~/.emacs.d/inits")

(server-start)



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

;; which-fund
(which-function-mode t)

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
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function nil)
 '(flycheck-idle-change-delay 1.0)
 '(helm-ff-file-compressed-list (quote ("epub" "gz" "bz2" "zip" "7z")))
 '(key-chord-two-keys-delay 0.01 t)
 '(open-junk-file-format "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S." t)
 '(package-selected-packages
   (quote
    (init-open-recentf yasnippet yard-mode yaml-mode which-key wgrep-ag web-mode w3m volatile-highlights visual-regexp use-package undo-tree tern-auto-complete sticky smartrep smartparens slim-mode scss-mode sass-mode ruby-end ruby-electric ruby-block rubocop robe recentf-ext projectile-rails prodigy popwin php-mode paredit pallet open-junk-file nyan-prompt nyan-mode nodejs-repl multiple-cursors multi-term markdown-mode magit-find-file magic-filetype key-chord init-loader idle-highlight-mode htmlize helm-swoop helm-smex helm-projectile helm-migemo helm-gtags helm-ghq helm-ag hamburg-theme gotham-theme gitignore-mode flycheck-elixir flycheck-cask flatland-theme flatland-black-theme expand-region exec-path-from-shell enh-ruby-mode emmet-mode elscreen elisp-slime-nav drag-stuff direx dired-k ddskk coffee-mode clues-theme beacon anzu annotate ag ac-slime ac-js2 ac-alchemist)))
 '(parens-require-spaces nil)
 '(recentf-auto-cleanup 100)
 '(recentf-auto-save-timer [nil 0 30 0 t recentf-save-list nil idle 0])
 '(recentf-exclude
   (quote
    ("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores")))
 '(recentf-max-saved-items 2000)
 '(rspec-use-rake-when-possible nil)
 '(show-paren-delay 0)
 '(sql-product (quote mysql))
 '(tab-width 2)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify)))





(add-to-list 'auto-mode-alist '("/Gemfile.lock\\'" . conf-mode))



;; (require 'w3m)
;; (define-key markdown-mode-map "\C-c\C-cm"
;;   (lambda ()
;;     (interactive)
;;     (w3m-find-file (buffer-file-name))))





;;; Others



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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
