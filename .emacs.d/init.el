(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)
(use-package "pallet")
(pallet-mode t)

(init-loader-load "~/.emacs.d/inits")

(server-start)


;; (load-file (expand-file-name "~/.emacs.d/shellenv.el"))
;; (dolist (path (reverse (split-string (getenv "PATH") ":")))
;;   (add-to-list 'exec-path path))


;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.90))

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

;; Lisp
(defvar my/emacs-lisp-ac-sources
  '(ac-source-features ac-source-functions ac-source-variables ac-source-symbols))

(defun my/emacs-lisp-mode-hook ()
  "My Emacs Lisp mode."
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
             'ac-alchemist-setup)

(sp-with-modes '(elixir-mode)
  (sp-local-pair "fn" "end"
         :when '(("SPC" "RET"))
         :actions '(insert navigate))
  (sp-local-pair "do" "end"
         :when '(("SPC" "RET"))
         :post-handlers '(sp-ruby-def-post-handler)
         :actions '(insert navigate)))

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
