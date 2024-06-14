(when (or load-file-name byte-compile-current-file)
  (setq user-emacs-directory
    (expand-file-name
      (file-name-directory (or load-file-name byte-compile-current-file)))))

(customize-set-variable
  'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
(package-initialize)
(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))

(leaf leaf-keywords
  :ensure t
  :init
  ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
  (leaf hydra :ensure t)
  (leaf el-get :ensure t)
  (leaf blackout :ensure t)

  :config
  ;; initialize leaf-keywords.el
  (leaf-keywords-init))

(leaf package
  :custom
  (package-native-compile . t))

(leaf ht :ensure t)

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

;;; GC
(setq gc-cons-threshold (* 128 1024 1024))
(setq-default gc-cons-percentage 0.5)

;; PATH
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-to-list 'exec-path "~/.local/bin")
(add-to-list 'exec-path "~/.cargo/bin")
(add-to-list 'exec-path "~/go/bin")

;;; Language
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;;; Environment:
(setenv "LC_ALL" "ja_JP.UTF-8")
(set-coding-system-priority 'utf-8)

(leaf bind-key :ensure t)
(leaf ace-window
  :url "https://github.com/abo-abo/ace-window"
  :ensure t
  :bind
  ("C-t" . ace-window)
  :custom
  (aw-keys . '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(leaf s :ensure t)

(defun my-find-file-init-el ()
  "init.elを開く"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun copy-buffer-name ()
  "編集中のファイル名またはバッファ名をコピペする"
  (interactive)
  (kill-new (or buffer-file-name
                (buffer-name))))

(defun split-window-right-and-balance ()
  "Split window horizontaly and balance windows."
  (interactive)
  (split-window-right)
  (balance-windows))

(defun split-window-below-and-balance ()
  "Split window vertically and balance windows."
  (interactive)
  (split-window-below)
  (balance-windows))

(defun delete-window-and-balance ()
  "Delete window and balance windows."
  (interactive)
  (delete-window)
  (balance-windows))

(defun openline-and-indent ()
  "Open line and indent."
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun open-blacket ()
  (newline-and-indent)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun end-of-bufferp (pos)
  (= (point-max) pos))

(defun between-blacketp ()
  (and (not (end-of-bufferp (point)))
       (or (and (progn
                  (skip-chars-backward " \t")
                  (string-equal (buffer-substring (- (point) 1) (point)) "("))
                (progn
                  (skip-chars-forward " \t")
                  (string-equal (buffer-substring (point) (+ (point) 1)) ")")))
           (and (progn
                  (skip-chars-backward " \t")
                  (string-equal (buffer-substring (- (point) 1) (point)) "{"))
                (progn
                  (skip-chars-forward " \t")
                  (string-equal (buffer-substring (point) (+ (point) 1)) "}")))
           (and (progn
                  (skip-chars-backward " \t")
                  (string-equal (buffer-substring (- (point) 1) (point)) "["))
                (progn
                  (skip-chars-forward " \t")
                  (string-equal (buffer-substring (point) (+ (point) 1)) "]"))))))

(defun newline-and-open-blacket ()
  "Add newline and indentation"
  (interactive)
  (if (between-blacketp)
      (open-blacket)
    (newline-and-indent)))

(defun org-find-file ()
  (interactive)
  (counsel-find-file "~/Dropbox/org"))

;;; Backupfile
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))
(setq auto-save-list-file-prefix "~/.emacs.d/backups/")
(setq create-lockfiles nil)

;;; Font
;; (set-face-attribute 'default nil :family "Ricty" :height 135)
(set-face-attribute 'default nil :family "Ricty" :height 135)

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
(leaf save-place
  :custom
  `((save-place-file . ,(concat user-emacs-directory "places"))))


;;; ミニバッファ履歴を次回Emacs起動時にも保存する
(savehist-mode 1)

;; 自動でバッファの再読み込み
(global-auto-revert-mode 1)

(add-to-list 'safe-local-variable-values '(rspec-docker-command . "docker-compose run --rm"))
(add-to-list 'safe-local-variable-values '(rspec-spec-command . "bundle exec rspec"))
(add-to-list 'safe-local-variable-values '(cargo-process--custom-path-to-bin . "/usr/local/cargo/bin/cargo"))

(leaf sudo-edit :ensure t)

;;; Bar
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode 0))

;; Column mode
(column-number-mode t)

;; 行番号の表示
(leaf display-line-numbers-mode
  :custom ((linum-format . "%4d"))
  :config
  (global-display-line-numbers-mode))

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

(leaf ivy
  :ensure t
  :custom
  (ivy-height . 30)
  (ivy-wrap . t)
  :bind
  ("C-c C-r" . ivy-resume)
  ("<f6>" . ivy-resume)
  :global-minor-mode t)

(leaf ivy-hydra
  :ensure t
  :custom
  (ivy-read-action-function #'ivy-hydra-read-action))

(setq enable-recursive-minibuffers t)

(leaf counsel
  :ensure t
  :bind (
  ("C-c g" . counsel-git)
  ("C-c j" . counsel-git-grep)
  ("C-c k" . counsel-rg)
  ("C-c o" . counsel-locate)
  ("C-s-o" . counsel-rhythmbox)
  ("C-;"   . counsel-switch-buffer)
  ("C-:"   . counsel-switch-buffer-other-window))
  :global-minor-mode t)

(leaf swiper
  :ensure t
  :bind
  ("C-s" . swiper))

(leaf ivy-ghq
  :el-get analyticd/ivy-ghq
  :custom
  (ivy-ghq-short-list . t)
  :bind
  ("C-x f" . ivy-ghq-open))

(leaf counsel-tramp
  :ensure t
  :bind
  ("C-x M-f" . counsel-tramp))

(leaf nerd-icons-ivy-rich
  :ensure t
  :init
  (nerd-icons-ivy-rich-mode 1)
  (ivy-rich-mode 1))

(defun evenp (integer) (cl-evenp integer))

(leaf ivy-rich
  :ensure t
  :init (ivy-rich-mode 1)
  :custom
  (ivy-rich-path-style 'abbrev)
  ;; :config
  ;; (ivy-rich-modify-column 'ivy-switch-buffer
  ;;   'ivy-rich-switch-buffer-major-mode
  ;;   '(:width 20))
  )

;; anzu
(leaf anzu
  :url "https://github.com/emacsorphanage/anzu"
  :ensure t
  :custom ((anzu-deactivate-region . t)
           (anzu-mode-lighter . "")
           (anzu-search-threshold . 1000)
           (tab-width . 2)
           (anzu-use-migemo . t))
  :global-minor-mode t)

(leaf migemo
  :ensure t
  :custom
  ((migemo-dictionary . "/usr/share/migemo/utf-8/migemo-dict")))
(leaf dash)
(leaf s)

;; (defun ytn-ivy-migemo-re-builder (str)
;;   (let* ((sep " \\|\\^\\|\\.\\|\\*")
;;          (splitted (--map (s-join "" it)
;;                           (--partition-by (s-matches-p " \\|\\^\\|\\.\\|\\*" it)
;;                                           (s-split "" str t)))))
;;     (s-join "" (--map (cond ((s-equals? it " ") ".*?")
;;                            ((s-matches? sep it) it)
;;                            (t (migemo-get-pattern it)))
;;                      splitted))))

;; (setq ivy-re-builders-alist '((t . ivy--regex-plus)
;;                               (swiper . ytn-ivy-migemo-re-builder)))

(leaf popwin
  :custom
  (popwin:popup-window-height . 0.4)
  ;; :config
  ;; (setq popwin:special-display-config
  ;;       (append popwin:special-display-config
  ;;               '(("*w3m*")
  ;;                 ("*slime-apropos*")
  ;;                 ("*slime-macroexpansion*")
  ;;                 ("*slime-description*")
  ;;                 ("*slime-compilation*" :noselect t)
  ;;                 ("*slime-xref*")
  ;;                 (slime-connection-list-mode)
  ;;                 (sldb-mode :height 40 :stick t)
  ;;                 slime-repl-mode
  ;;                 slime-connection-list-mode
  ;;                 (direx:direx-mode :position left :width 40 :dedicated t)
  ;;                 ("*quickrun*")
  ;;                 (dired-mode :position top)
  ;;                 ("*Shell Command Output*")
  ;;                 (compilation-mode :noselect t))))
  )

;;; Color Theme
(leaf doom-themes
  :ensure t neotree
  :custom ((doom-themes-enable-italic . t)
           (doom-themes-enable-bold . t))
  :custom-face
  (doom-modeline-bar . '((t (:background "#6272a4"))))
  :config
  (load-theme 'doom-monokai-pro t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(leaf doom-modeline
  :ensure t
  :custom ((doom-modeline-buffer-file-name-style . 'relative-from-project)
           (doom-modeline-icon . t)
           (doom-modeline-major-mode-icon . nil)
           (doom-modeline-minor-modes . nil)
           (doom-modeline-vcs-max-length . 20))
  :hook
  (after-init-hook . doom-modeline-mode)
  :config
  (line-number-mode 0)
  (column-number-mode 0)
  (doom-modeline-def-modeline 'main
    '(bar window-number matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info persp-name lsp github debug minor-modes input-method major-mode process vcs checker)))

(custom-set-faces
  '(line-number ((t (:inherit default :foreground "dark gray" :strike-through nil :underline nil :slant normal :weight normal)))))

;; 選択中の色
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
  "*Face used by hl-line."
  :group 'hl-line)
(leaf hl-line
  :custom
  (hl-line-face . 'hlline-face))

(global-hl-line-mode)

(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " Ys")
    (paredit-mode . " Pe")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . " Ut")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    (editorconfig . " Ec")
    ;; Major modes
    (emacs-lisp-mode . "El")
    (lisp-interaction-mode . "Li")
    (python-mode . "Py")
    (ruby-mode   . "Rb")
    (emacs-lisp-mode . "El")
    (markdown-mode . "Md")))

(defun clean-mode-line ()
  (interactive)
  (cl-loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

;; (defvar sticky-buffer-previous-header-line-format)
;; (define-minor-mode sticky-buffer-mode
;;   "Make the current window always display this buffer."
;;   nil " sticky" nil
;;   (if sticky-buffer-mode
;;       (progn
;;         (set (make-local-variable 'sticky-buffer-previous-header-line-format)
;;              header-line-format)
;;         (set-window-dedicated-p (selected-window) sticky-buffer-mode))
;;     (set-window-dedicated-p (selected-window) sticky-buffer-mode)
;;     (setq header-line-format sticky-buffer-previous-header-line-format)))

;; White space
(leaf whitespace
  :custom
  (whitespace-display-mappings . '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  :custom-face
  (whitespace-style . '(face trailing tabs space-mark tab-mark))
  (whitespace-trailing . '((t (:foreground "magenta" :underline t :background nil)))))

(leaf smart-hungry-delete
  :ensure t
  :bind (("<backspace>" . smart-hungry-delete-backward-char)
		 ("C-d" . smart-hungry-delete-forward-char))
  :leaf-defer nil ;; dont defer so we can add our functions to hooks
  :config (smart-hungry-delete-add-default-hooks))

;; Auto-Complete
(leaf company
  :ensure t
  :custom
  (company-idle-delay . 0.1)
  (company-minimum-prefix-length . 2)
  (company-selection-wrap-around . t)
  :bind ((company-mode-map
          ("M-i" . company-complete))
         (company-active-map
           ("C-n" . company-select-next)
           ("C-p" . company-select-previous)
           ("C-s" . company-search-words-regexp))
         (company-search-map
           ("C-n" . company-select-next)
           ("C-p" . company-select-previous))))

(leaf company-box
  :ensure t
  :hook (company-mode-hook . company-box-mode))

;; Flycheck
(leaf flycheck
  :ensure t
  :bind (("M-g l" . flycheck-list-errors))
  :custom
  (flycheck-display-errors-delay . 0.1)
  (flycheck-idle-change-delay . 1.0))

(leaf flycheck-posframe
  :ensure t
  :hook
  (flycheck-mode-hook . flycheck-posframe-mode)
  :custom
  (flycheck-posframe-position . 'window-top-right-corner))

;; paren
(show-paren-mode t)
(custom-set-variables
 '(show-paren-delay 0)
 '(parens-require-spaces nil))

;; Smartparens
(leaf smartparens
  :ensure t
  :hook (after-init-hook . smartparens-global-mode)
  :require smartparens-config
  :custom (electric-pair-mode . nil)
  :config (sp-pair "<%" " %>")
  :global-minor-mode t)

(leaf paredit :leaf-defer t
  :ensure t
  :hook
  ((emacs-lisp-mode-hook lisp-interacton-mode-hook scheme-mode-hook slime-mode-hook inferior-scheme-mode-hook slime-repl-mode-hook) . enable-paredit-mode)
  :bind (paredit-mode-map
         ("C-<right>" . 'right-word)
         ("C-<left>"  . 'left-word)
         (";;"        . 'paredit-semicolon)
         (";"         . nil)
         ("C-j"       . nil)))

;; ;; dired-k
(leaf dired-k :leaf-defer t
  :ensure t
  :hook
  (dired-initial-position-hook . dired-k)
  :bind
  (dired-mode-map
   ("K" . dired-k)
   ("C-t" . other-window)))

(leaf neotree
  :after
  projectile
  :commands
  (neotree-show neotree-hide neotree-dir neotree-find)
  :custom
  (neo-show-hidden-files . t)
  `(neo-theme ,(if (display-graphic-p) 'icons 'arrow))
  :bind
  ("C-M-\\" . neotree-projectile-toggle)
  :preface
  (defun neotree-projectile-toggle ()
    (interactive)
    (let ((project-dir
           (ignore-errors
             ;; Pick one: projectile or find-file-in-project
             (projectile-project-root)))
          (file-name (buffer-file-name))
          (neo-smart-open t))
      (if (and (fboundp 'neo-global--window-exists-p)
               (neo-global--window-exists-p))
          (neotree-hide)
        (progn
          (neotree-show)
          (if project-dir
              (neotree-dir project-dir))
          (if file-name
              (neotree-find file-name)))))))

(put 'dired-find-alternate-file 'disabled nil)

(leaf smartrep :ensure t
  :config
  (declare-function smartrep-define-key "smartrep"))

(global-unset-key (kbd "C-q"))
(leaf tab-bar-mode
  :custom
  (tab-bar-new-tab-choice . "*scratch*")
  (tab-bar-tab-hints . t)
  (tab-bar-show . 1)
  (tab-bar-new-button-show . nil)
  (tab-bar-close-button-show . nil)
  :global-minor-mode t
  :smartrep (global-map
              "C-q"
              (("c" tab-bar-new-tab "Create new tab")
                ("k" tab-bar-close-tab "Close current tab")
                ("C-k" tab-bar-close-tab "Close current tab")
                ("n" tab-bar-switch-to-next-tab "Switch to next tab")
                ("p" tab-bar-switch-to-prev-tab "Switch to prev tab"))))

;; (defhydra hydra-tab-bar (global-map "C-q")
;;   "tab-bar"
;;   ("c" tab-bar-new-tab "Create new tab")
;;   ("k" tab-bar-close-tab "Close current tab")
;;   ("C-k" tab-bar-close-tab "Close current tab")
;;   ("n" tab-bar-switch-to-next-tab "Switch to next tab")
;;   ("p" tab-bar-switch-to-prev-tab "Switch to prev tab"))

(defun my/emacs-lisp-mode-hook ()
  "My Emacs Lisp mode."
  (set-face-foreground 'font-lock-regexp-grouping-backslash "indian red")
  (set-face-foreground 'font-lock-regexp-grouping-construct "peru"))

(defvar my/emacs-lisp-modes
  '(emacs-lisp-mode-hook lisp-interaction-mode-hook ielm-mode-hook))

(dolist (elt my/emacs-lisp-modes)
  (add-hook elt 'turn-on-eldoc-mode)
  (add-hook elt 'my/emacs-lisp-mode-hook))

(set-face-foreground 'font-lock-regexp-grouping-backslash "green3")
(set-face-foreground 'font-lock-regexp-grouping-construct "green")

(leaf lispxmp)

(leaf javascript-mode :leaf-defer t
  :config
  (custom-set-variables '(js-indent-level 2)))

(leaf json-mode :leaf-defer t
  :config
  (custom-set-variables '(js-indent-level 2)))

(leaf tern :leaf-defer t)

(leaf vue-mode :leaf-defer t)
(leaf js2-mode :leaf-defer t
  :ensure t
  :mode
  (("\\.js\\'" . js2-mode)
   ("\\.es6\\'" . js2-mode))
  :custom
  (js2-basic-offset . 2))

(leaf yasnippet :ensure t
  :hook
  (lsp-mode-hook . yas-minor-mode)
  :custom
  (yas-snippet-dirs . '("~/.emacs.d/snippets")))

(leaf yasnippet-snippets :ensure t)

(leaf ivy-yasnippet
  :ensure t
  :after (yasnippet)
  :bind (("C-c y" . ivy-yasnippet)
         ("C-c C-y" . ivy-yasnippet)))


(leaf lsp-mode
  :ensure t
  :custom
  ;; debug
  (lsp-print-io . nil)
  (lsp-trace . nil)
  (lsp-print-performance . nil)
  ;; general
  (lsp-auto-guess-root . t)
  (lsp-document-sync-method . 'incremental) ;; always send incremental document
  (lsp-response-timeout . 5)
  ;; (lsp-enable-completion-at-point . nil)
  (lsp-enable-snippet . t)
  (lsp-prefer-capf . t)
  (lsp-completion-provider . :capf)
  (lsp-keymap-prefix . "C-c C-l")
  (lsp-document-sync-method . 2)
  (read-process-output-max . 4000)
  (lsp-rust-server . 'rust-analyzer)
  :hook
  ((rust-mode-hook haskell-mode-hook vue-mode-hook ruby-mode-hook go-mode-hook c-mode-hook) . lsp)
  :bind
  (lsp-mode-map ("C-c R"   . lsp-rename)
                ("C-c C-j" . lsp-execute-code-action)))

(with-eval-after-load "lsp-rust"
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "rust-analyzer")
                    :remote? t
                    :major-modes '(rust-mode rustic-mode)
                    :initialization-options 'lsp-rust-analyzer--make-init-options
                    :notification-handlers (ht<-alist lsp-rust-notification-handlers)
                    :action-handlers (ht ("rust-analyzer.runSingle" #'lsp-rust--analyzer-run-single)
                                         ("rust-analyzer.debugSingle" #'lsp-rust--analyzer-debug-lens)
                                         ("rust-analyzer.showReferences" #'lsp-rust--analyzer-show-references))
                    :library-folders-fn (lambda (_workspace) lsp-rust-library-directories)
                    :after-open-fn (lambda ()
                                     (when lsp-rust-analyzer-server-display-inlay-hints
                                       (lsp-rust-analyzer-inlay-hints-mode)))
                    :ignore-messages nil
                    :server-id 'rust-analyzer-remote)))

(with-eval-after-load "lsp-solargraph"
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection '("bundle" "exec" "rubocop" "--lsp"))
                    :major-modes '(ruby-mode enh-ruby-mode)
                    :priority 1
                    :remote? t
                    :multi-root t
                    :server-id 'rubocop-ls-remote
                    :initialized-fn (lambda (workspace)
                                      (with-lsp-workspace workspace
                                                          (lsp--set-configuration
                                                           (lsp-configuration-section "rubocop")))))))

(with-eval-after-load "lsp-solargraph"
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection '("solargraph" "stdio"))
                    :major-modes '(ruby-mode enh-ruby-mode)
                    :priority 10
                    :remote? t
                    :multi-root t
                    :server-id 'ruby-ls-remote
                    :initialized-fn (lambda (workspace)
                                      (with-lsp-workspace workspace
                                                          (lsp--set-configuration
                                                           (lsp-configuration-section "solargraph")))))))

(with-eval-after-load "lsp-go"
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection
                                     (lambda () (cons lsp-go-gopls-server-path lsp-go-gopls-server-args)))
                    :major-modes '(go-mode go-dot-mod-mode)
                    :remote? t
                    :language-id "go"
                    :priority 1
                    :server-id 'gopls-remote
                    :completion-in-comments? t
                    :library-folders-fn #'lsp-go--library-default-directories
                    :after-open-fn (lambda ()
                                     ;; https://github.com/golang/tools/commit/b2d8b0336
                                     (setq-local lsp-completion-filter-on-incomplete nil))))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection
                                     (lambda () (cons lsp-gopls-server-path lsp-gopls-server-args)))
                    :major-modes '(go-mode go-dot-mod-mode)
                    :priority 0
                    :remote? t
                    :server-id 'gopls-remote
                    :library-folders-fn 'lsp-clients-go--library-default-directories)))

(leaf lsp-ui
  :ensure t
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable . t)
  (lsp-ui-doc-header . t)
  (lsp-ui-doc-include-signature . t)
  (lsp-ui-doc-position . 'top) ;; top, bottom, or at-point
  (lsp-ui-doc-max-width . 150)
  (lsp-ui-doc-max-height . 30)
  (lsp-ui-doc-use-childframe . t)
  (lsp-ui-doc-use-webkit . t)
  (lsp-ui-doc-show-with-cursor . t)
  ;; (lsp-ui-doc-alignment . 'window)
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable . t)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable . nil)
  (lsp-ui-sideline-ignore-duplicate . t)
  (lsp-ui-sideline-show-symbol . t)
  (lsp-ui-sideline-show-hover . t)
  (lsp-ui-sideline-show-diagnostics . t)
  (lsp-ui-sideline-show-code-actions . nil)
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable . nil)
  (lsp-ui-imenu-kind-position . 'top)
  ;; lsp-ui-peek
  (lsp-ui-peek-enable . t)
  (lsp-ui-peek-peek-height . 20)
  (lsp-ui-peek-list-width . 50)
  (lsp-ui-peek-fontify . 'on-demand) ;; never, on-demand, or always
  (lsp-modeline-code-actions-segments . '(icon count name))
  :bind
  (lsp-mode-map
        ("C-c C-r" . lsp-ui-peek-find-references)
        ("M-."     . lsp-ui-peek-find-definitions)
        ("C-c i"   . lsp-ui-peek-find-implementation)
        ("C-c m"   . lsp-ui-imenu)
        ("C-c s"   . lsp-ui-sideline-mode)
        ("C-c d"   . wat-aro/toggle-lsp-ui-doc)
        ("C-c h"   . lsp-describe-thing-at-point))
  :hook
  (lsp-mode-hook . lsp-ui-mode))

(leaf lsp-ui-doc
  :preface
  (defun wat-aro/toggle-lsp-ui-doc ()
    (interactive)
    (if lsp-ui-doc-mode
        (progn
          (lsp-ui-doc-mode -1)
          (lsp-ui-doc--hide-frame))
      (lsp-ui-doc-mode 1))))



(leaf ruby-mode :leaf-defer t
  :interpreter (("ruby" . ruby-mode))
  :mode ("\\.jb\\'" . ruby-mode)
  :hook
  (ruby-mode-hook . inf-ruby-switch-setup)
  :custom
  (ruby-deep-indent-paren . nil)
  (ruby-insert-encoding-magic-comment . nil)
  (lsp-solargraph-use-bundler . nil))

;; inf-ruby
(leaf inf-ruby :leaf-defer t
  :ensure t
  :hook
  (inf-ruby-mode-hook . ansi-color-for-comint-mode-on)
  :custom
  (inf-ruby-default-implementation . "pry")
  (inf-ruby-eval-binding . "Pry.toplevel_binding"))

;; RSpec
(leaf rspec-mode :leaf-defer t
  :ensure t
  :hook
  (ruby-mode-hook . rspec-mode)
  :custom
  (compilation-scroll-output . t)
  ;; (rspec-spec-command . "bundle exec")
  (rspec-command-options . "--format documentation")
  (rspec-use-bundler-when-possible . t)
  :defer-config
  (rspec-install-snippets))

;; minitest
;; (leaf minitest :leaf-defer t
;;   :ensure t
;;   :hook
;;   (ruby-mode-hook . minitest-mode)
;;   :custom
;;   (minitest-use-rails . t)
;;   (minitest-use-bundler . nil)
;;   :config
;;   (minitest-install-snippets))

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

;; Projectile
(leaf projectile :leaf-defer t
  :url "https://github.com/bbatsov/projectile/blob/5703797bb2a400e962479e670086aca4241a77b7/projectile.el"
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  :custom
  (projectile-mode-line
   '(:eval (format " Projectile[%s]"
                   (projectile-project-name))))
  :bind
  ("C-c p" . projectile-command-map))

(leaf projectile-rails
  :ensure t
  :init
  (projectile-rails-global-mode)
  (define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map))

(leaf rinari :leaf-defer t
  :ensure t
  :hook
  (ruby-mode-hook . rinari-minor-mode))

(leaf rubocop :leaf-defer t
  :ensure t
  :hook
  (ruby-mode-hook . rubocop-mode)
  :custom
  `((rubocop-keymap-prefix . ,(kbd "C-c ."))
    (rubocop-autocorrect-on-save . t)))

(leaf yaml-mode :ensure t)

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

(leaf scheme :leaf-defer t
  :mode ("\\.scm\\'" . scheme-mode)
  :bind (shceme-mode-map ("C-c g" . scheme-other-window))
  :config
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
  (put 'guard 'scheme-indent-function 1))

(leaf go-mode :ensure t :leaf-defer t
  :mode
  ("\\.go\\'" . go-mode)
  :init
  (add-hook 'before-save-hook 'lsp-format-buffer)
  (add-hook 'before-save-hook 'lsp-organize-imports)
  :hook (go-mode-hook . (lambda () (setq tab-width 4))))

(leaf c-mode
  :hook
  (c-mode-hook . company-mode)
  (c-mode-hook . flycheck-mode)
  (c-mode-hook . (lambda () (progn (setq comment-start "// ") (setq comment-end "")))))

(leaf ansi-color
  :require ansi-color
  :hook
  (compilation-filter-hook . (lambda ()
                               (ansi-color-apply-on-region (point-min) (point-max)))))

(leaf haskell-mode :leaf-defer t
  :ensure t
  :hook
  (haskell-mode-hook . flycheck-mode))

(leaf lsp-haskell :leaf-defer t)

(leaf proof-general :leaf-defer t)

(leaf company-coq :leaf-defer t
  :hook
  (coq-mode-hook . company-coq-mode))

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
  ;; (setq web-mode-ac-sources-alist
  ;;       '(("css" . (ac-source-css-property))
  ;;         ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t))

(defun sp-web-mode-is-code-context  (id action context)
  "This snippet is derived from http://web-mode.org/ ."
  (when (and (eq action 'insert)
             (not (or (get-text-property (point) 'part-side)
                      (get-text-property (point) 'block-side))))
    t))

(leaf web-mode
  :leaf-defer t
  :ensure t
  :init
  (--each '("\\.html?\\'" "\\.tpl\\'" "\\.tpl\\.xhtml\\'" "\\.ejs\\'" "\\.hbs\\'"
            "\\.html\\.erb\\'" "\\.html\\+smartphone\\.erb\\'" "\\.css?\\'"
            "\\.js\\.coffee\\.erb\\'" "\\.js\\.erb\\'" "\\.mustache\\'")
    (add-to-list 'auto-mode-alist (cons it 'web-mode)))
  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context))
  :hook
  (web-mode-hook . my/web-mode-hook)
  (web-mode-hook . emmet-mode)
  :config
  (setq web-mode-markup-indent-offset 2)
  (flycheck-mode t))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'html-tidy 'web-mode)
  (flycheck-add-mode 'css-csslint 'web-mode))

(leaf slim-mode
  :ensure t
  :hook
  (slim-mode-hook . (lambda () (flycheck-mode t)))
  :mode
  ("\\.slim\\'" . slim-mode)
  ("\\.html\\.slim\\'" . slim-mode))

(leaf haml-mode
  :ensure t
  :mode
  ("\\.haml\\'" . haml-mode)
  ("\\.html\\.haml\\'" . haml-mode))

(leaf sass-mode
  :ensure t)

;; Emmet-mode
(leaf emmet-mode :leaf-defer t
  :hook
  ((web-mode-hook css-mode-hook) . emmet-mode)
  :bind (emmet-mode-keymap
         ("C-c j" . emmet-expand-line)
         ("C-c j  . nil")))

(leaf elm-mode :leaf-defer t
  :custom
  (elm-indent-offset . 4)
  (elm-tags-on-save . t)
  (elm-tags-exclude-elm-stuff . nil)
  :hook
  (elm-mode-hook . elm-oracle-setup-completion)
  (elm-mode-hook . (lambda ()
                (company-mode)))
  :config
  (flycheck-mode t)
  (flycheck-elm-setup))


(leaf clojure-mode :leaf-defer t
  :hook
  (clojure-mode-hook . paredit-mode)
  :custom
  (clojure-align-forms-automatically . t))

(leaf cider :leaf-defer t
  :ensure t
  :hook
  (cider-mode-hook . clj-refactor-mode)
  ((cider-mode-hook cider-repl-mode-hook) . company-mode)
  ((cider-mode-hook cider-repl-mode-hook) . eldoc-mode)
  ((cider-mode-hook cider-repl-mode-hook) . paredit-mode)
  (cider-mode-hook . helm-cider-mode)
  (cider-repl-mode-hook . helm-cider-mode)
  :custom
  (nrepl-log-messages . t)
  (cider-repl-display-in-current-window . t)
  (cider-repl-use-clojure-font-lock . t)
  (cider-prompt-save-file-on-load . 'always-save)
  (cider-font-lock-dynamically . '(macro core function var))
  (cider-overlays-use-font-lock . t)
  :config
  (cider-repl-toggle-pretty-printing))

(leaf rust-mode :leaf-defer t
  :ensure t
  :custom
  (rust-format-on-save . t)
  :bind
  (rust-mode-map ("C-m" . newline-and-open-blacket)))

(defun cargo-process-files (from-path)
  "Cargo のプロジェクトルートから from-path にあるファイルのリストを返す"
  (let* ((path (concat (file-name-as-directory (cargo-process--project-root)) from-path))
          (files (seq-filter (lambda (path) (string-match-p ".rs$" path)) (directory-files path)))
          (names (mapcar (lambda (file) (s-chop-suffixes '(".rs") file)) files)))
    (completing-read "Select files: " names)))

(defun cargo-run-bin ()
  "Select run bin file for cargo"
  (interactive)
  (let* ((bin (cargo-process-files "src/bin")))
    (cargo-process--start (concat "Run " bin)
      (concat cargo-process--command-run-bin " " bin))))

(defun cargo-process-run-example-completing ()
  "Select run bin file for cargo"
  (interactive)
  (let* ((example (cargo-process-files "examples")))
    (cargo-process--start (concat "Run " example)
      (concat cargo-process--command-run-example " " example))))

(leaf cargo
  :leaf-defer t
  :ensure t
  :require cargo
  :hook (rust-mode-hook . cargo-minor-mode)
  :bind (:cargo-minor-mode-command-map
          ("C-i" . cargo-run-bin)
          ("C-X" . cargo-process-run-example-completing)))

(leaf typescript-mode :leaf-defer t
  :custom
  (typescript-indent-level . 2)
  :mode (("\\.ts\\'"  . typescript-mode)
         ("\\.tsx\\'" . typescript-mode)))

(leaf csharp-mode)

;; Markdown Mode
(leaf markdown-mode :leaf-defer t
  :mode ("\\.md\\'" . gfm-mode)
  :custom
  (markdown-indent-on-enter . nil)
  :config
  ;; (markdown-make-gfm-checkboxes-buttons)
  (visual-line-mode nil)
  :bind (markdown-mode-map ("C-c C-c C-l" . markdown-insert-link)
                           ("C-c C-c C-i" . markdown-insert-image)
                           ("C-c C-c C-c" . markdown-insert-gfm-code-block)))

;; org
(defun my-org-confirm-babel-evaluate (lang body)
  (not (or (string= lang "ditaa")
           (string= lang "emacs-lisp")
           (string= lang "ruby")
           (string= lang "C")
           (string= lang "cpp")
           (string= lang "python"))))
(leaf org :leaf-defer t
  :custom* ((org-agenda-files (list "~/Dropbox/org/tasks.org" "~/Dropbox/org/notes.org" "~/Dropbox/org/schedule.org"))
            (org-hide-leading-stars t)
            (org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
            (org-todo-keywords '((sequence "TODO" "DOING" "DONE")))
            (org-use-speed-commands t)
            (org-startup-truncated nil)
            (org-src-fontify-natively t)
            (org-capture-templates '(("t" "Task" entry (file+headline "~/Dropbox/org/tasks.org" "Tasks") "** TODO %? \n")
                                     ("n" "Note" entry (file+headline "~/Dropbox/org/notes.org" "Notes"))
                                     ("s" "Schedule" entry (file+headline "~/Dropbox/org/schedule.org" "Schedule") "** %?\n   SCHEDULED: %t")
                                     ("9" "9sako6" entry (file+headline "~/Dropbox/org/9sako6.org" "9sako6") "** %t\n*** 最近どうですか\n%?"))))
  :bind
  ("C-c c" . org-capture)
  ("C-c a" . org-agenda)
  :config
  (toggle-truncate-lines t))

(leaf org-bullets
  :ensure t
  ;;:custom (org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" ""))
  :hook (org-mode-hook . org-bullets-mode))

(leaf fish-mode :leaf-defer t)

(leaf terraform-mode :leaf-defer t
  :ensure t
  :custom
  (terraform-indent-level . 4))

;; Magit
(leaf magit
  :ensure t
  :leaf-defer t
  :custom
  (magit-auto-revert-mode . nil)
  (vc-handled-backends . '())
  :bind (("C-x m" . magit-status)
         ("C-c l" . magit-blame))
  :hook
  (vc . (remove-hook 'find-file-hooks 'vc-find-file-hook)))

;; (leaf docker-tramp :ensure t)

(leaf docker
  :ensure t
  :bind
  ("C-c C-m" . docker))

(leaf dockerfile-mode
  :leaf-defer t
  :ensure t)

(leaf docker-compose-mode
  :leaf-defer t
  :ensure t)

(custom-set-variables
  '(enable-remote-dir-locals t))
(leaf tramp
  :defer-config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(leaf pest-mode
  :ensure t)

;; Open junk file
(defun open-junk-file-directory ()
  (interactive)
  (counsel-find-file "~/Documents/junk/"))

(leaf request :ensure t :leaf-defer t)

(leaf request :ensure t :leaf-defer t)

(defun globalip-me ()
  (interactive)
  (request "https://globalip.me"
    :parser 'buffer-string
    :success (cl-function
               (lambda (&key data &allow-other-keys)
                 (let ((globalip (substring data 0 (- (length data) 1))))
                   (kill-new globalip)
                   (message globalip))))))

(defun open-sg ()
  (interactive)
  (request "https://globalip.me"
    :parser 'buffer-string
    :success (cl-function
               (lambda (&key data &allow-other-keys)
                 (let* ((globalip (substring data 0 (- (length data) 1)))
                        (text (concat "@hubot dev open_sg " globalip)))
                   (kill-new text)
                   (message text))))))


(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(leaf open-junk-file
  :ensure t
  :custom
  (open-junk-file-format . "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S.")
  :bind
  ("C-x j" . open-junk-file)
  ("C-x J" . open-junk-file-directory))

;; multiple-cursors
(leaf multiple-cursors
  :ensure t
  :defer-config
  :init
  :smartrep ("C-."
              (("C-'" . 'mc/mark-next-like-this)
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
                ("O"   . 'mc/reverse-regions)))
  :bind  (("C-M-c" . mc/edit-lines)
           ("C-M-r" . mc/mark-all-in-region)))

(leaf editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; which-fund
(which-function-mode t)

;; Undo Tree
(leaf undo-tree
  :ensure t
  :defer-config
  (global-undo-tree-mode)
  :bind
  (undo-tree-map
   ("C-/" . undo-tree-undo)
   ("C-'" . undo-tree-redo)))

;; expand-region.el
(leaf expand-region :leaf-defer t
  :bind (("C-@" . er/expand-region)
         ("C-`" . er/contract-region)))

;; Visual
(leaf visual-regexp
  :ensure t
  :bind
  ("M-%" . vr/query-replace))

;; which-key
(leaf which-key
  :ensure t
  :init
  (which-key-setup-side-window-right-bottom)
  (which-key-mode t))

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
(leaf beacon
  :ensure t
  :init
  (beacon-mode 1))


;; nyan-mode
(leaf nyan-mode
  :ensure t
  :custom
  (nyan-bar-length . 16)
  :global-minor-mode t)

(leaf ddskk
  :ensure t
  :require skk
  :custom
  (skk-jisyo . "~/.skk-jisyo")
  (skk-large-jisyo . "/usr/share/skk/SKK-JISYO.L"))
;;(require 'skk)
(bind-keys
  ("C-x C-j" . skk-mode)
  ("C-\\" . skk-mode))
(setq default-input-method "japanese-skk")
(setq skk-show-inline 'vertical)

(leaf direnv)

;; exchange meta-key to super-key
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier 'super)

;;; Key
;;(keyboard-translate ?\C-h ?\C-?)
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

(setq compilation--start-time nil)

(require 'misc)

(bind-keys
  ("C-?"       . help-command)
  ("C-o"       . openline-and-indent)
  ("C-m"       . newline-and-indent)
  ("C-M-m"     . newline)
  ("C-x j"     . open-junk-file)
  ("C-S-n"     . make-frame)
  ("C-S-w"     . delete-frame)
  ("C-c n"     . multi-term-next)
  ("C-c t"     . toggle-truncate-lines)
  ("C-c v"     . revert-buffer)
  ("C-S-t"     . other-frame)
  ("C-M-%"     . ez-query-replace)
  ("C-x C-M-%" . ez-query-replace-repeat)
  ("C-c |"     . org-store-link)
  ("C-c C-z"   . window-resizer)
  ("<f8>"      . neotree-toggle)
  ("M-\\"      . dired)
  ("C-x 3"     . split-window-right-and-balance)
  ("C-x 2"     . split-window-below-and-balance)
  ("C-x 0"     . delete-window-and-balance)
  ("M-f"       . forward-to-word)
  ("M-F"       . forward-word)
  ("M-b"       . backward-word)
  ("M-B"       . backward-to-word))

(setq windmove-wrap-around t)


(provide 'init)
