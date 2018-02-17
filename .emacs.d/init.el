(package-initialize)

(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)

(use-package pallet
  :init
  (pallet-mode t))


(use-package init-loader
  :init
  (init-loader-load "~/.emacs.d/inits"))


(server-start)
(init-open-recentf)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#26292c" "#ff4a52" "#40b83e" "#f6f080" "#afc4db" "#dc8cc3" "#93e0e3" "#f8f8f8"])
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(anzu-use-migemo t)
 '(beacon-color "#cc6666")
 '(clojure-align-forms-automatically t)
 '(coffee-indent-like-python-mode t)
 '(coffee-tab-width 2)
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "44c566df0e1dfddc60621711155b1be4665dd3520b290cb354f8270ca57f8788" "dd6e52a5b1180f5c8bf408764a32867e2fa86594ded78a29040cafce6a4ea808" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "962dacd99e5a99801ca7257f25be7be0cebc333ad07be97efd6ff59755e6148f" "bdaab014ec6785f64b72efbea80808b762d8971247aacf2ffc6b76a39b9ed97c" default)))
 '(elm-indent-offset 4)
 '(elscreen-buffer-to-nickname-alist
   (quote
    (("^Projectile"
      (lambda nil
        (format "%s"
                (projectile-project-name))))
     ("^dired-mode$" lambda nil
      (format "Dired(%s)" dired-directory))
     ("^Info-mode$" lambda nil
      (format "Info(%s)"
              (file-name-nondirectory Info-current-file)))
     ("^mew-draft-mode$" lambda nil
      (format "Mew(%s)"
              (buffer-name
               (current-buffer))))
     ("^mew-" . "Mew")
     ("^irchat-" . "IRChat")
     ("^liece-" . "Liece")
     ("^lookup-" . "Lookup"))))
 '(elscreen-display-screen-number nil)
 '(elscreen-display-tab 20)
 '(elscreen-mode-to-nickname-alist
   (quote
    (("[Ss]hell" . "shell")
     ("compilation" . "compile")
     ("-telnet" . "telnet")
     ("dict" . "OnlineDict")
     ("*WL:Message*" . "Wanderlust"))))
 '(elscreen-prefix-key (kbd "C-z"))
 '(elscreen-tab-display-control nil)
 '(elscreen-tab-display-kill-screen nil)
 '(fci-rule-color "#202325")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function nil)
 '(flycheck-idle-change-delay 1.0)
 '(flycheck-pos-tip-mode t)
 '(fringe-mode 10 nil (fringe))
 '(hasKell-indentation-where-pre-offset 2)
 '(haskell-compile-cabal-build-command "stack build")
 '(haskell-indent-thenelse 4)
 '(haskell-indentation-layout-offset 4)
 '(haskell-indentation-left-offset 4)
 '(haskell-indentation-starter-offset 4)
 '(haskell-indentation-where-post-offset 2)
 '(haskell-process-args-ghci "ghci")
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-path-ghci "stack")
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci))
 '(haskell-stylish-on-save t)
 '(helm-ff-file-compressed-list (quote ("epub" "gz" "bz2" "zip" "7z" "/backup")))
 '(helm-for-files-preferred-list
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-bookmarks helm-source-file-cache helm-source-files-in-current-dir helm-source-locate helm-source-ghq)))
 '(inf-ruby-console-rails-default-implementation "pry")
 '(inf-ruby-default-implementation "pry")
 '(inf-ruby-eval-binding "Pry.toplevel_binding" t)
 '(js-indent-level 2)
 '(key-chord-two-keys-delay 0.01 t)
 '(linum-format " %6d ")
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(markdown-indent-on-enter nil)
 '(markdown-make-gfm-checkboxes-buttons nil)
 '(migemo-coding-system (quote utf-8))
 '(migemo-command "cmigemo")
 '(migemo-dictionary
   "/usr/local/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")
 '(migemo-options (quote ("-q" "--emacs")))
 '(migemo-regex-dictionary nil)
 '(migemo-user-dictionary nil)
 '(open-junk-file-directory "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S." t)
 '(open-junk-file-format "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S." t)
 '(package-selected-packages
   (quote
    (all-the-icons neotree atom-one-dark-theme atom-dark-theme intero flycheck-haskell ghc direnv pug-mode rbenv flycheck-elm json-mode lispxmp racer rust-mode rspec-mode esa editor-config google-translate helm-cider clj-refactor cider clojure-mode flycheck-scala-sbt ensime vue-mode hindent fish-mode crosshairs elm-mode helm-tramp sudo-edit selected tuareg magit-find-file magit package-utils helm-descbinds ez-query-replace helm-themes expand-line flycheck-pos-tip terraform-mode ac-haskell-process haskell-mode helm-git-grep yasnippet yard-mode yaml-mode which-key wgrep-ag web-mode volatile-highlights visual-regexp use-package undo-tree tern-auto-complete sticky smartrep smartparens slim-mode scss-mode sass-mode ruby-block robe recentf-ext projectile-rails prodigy popwin php-mode paredit pallet open-junk-file nyan-prompt nyan-mode nodejs-repl multiple-cursors multi-term markdown-mode magic-filetype key-chord init-open-recentf init-loader idle-highlight-mode htmlize helm-swoop helm-smex helm-projectile helm-gtags helm-ghq helm-ag hamburg-theme gotham-theme gitignore-mode flycheck-ocaml flycheck-elixir flycheck-cask flatland-theme flatland-black-theme exec-path-from-shell emmet-mode elscreen elisp-slime-nav drag-stuff direx dired-k coffee-mode clues-theme beacon anzu annotate ag ac-slime ac-js2 ac-alchemist)))
 '(parens-require-spaces nil)
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(projectile-completion-system (quote helm))
 '(projectile-mode-line
   (quote
    (:eval
     (format " Projectile[%s]"
             (projectile-project-name)))))
 '(rbenv-show-active-ruby-in-modeline nil)
 '(recentf-auto-cleanup 600)
 '(recentf-auto-save-timer [nil 0 30 0 t recentf-save-list nil idle 0])
 '(recentf-exclude
   (quote
    ("/recentf" "/elpa/" "/elisps/" "\\'/tmp/" "/\\.git/" "/\\.cask/" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores")))
 '(recentf-max-saved-items 2000)
 '(rspec-use-rake-when-possible nil)
 '(ruby-deep-indent-paren nil)
 '(ruby-insert-encoding-magic-comment nil)
 '(safe-local-variable-values
   (quote
    ((haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4))))
 '(scss-compile-at-save nil)
 '(show-paren-delay 0)
 '(tab-width 2)
 '(terraform-indent-level 4)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(vc-annotate-background "#1f2124")
 '(vc-annotate-color-map
   (quote
    ((20 . "#ff0000")
     (40 . "#ff4a52")
     (60 . "#f6aa11")
     (80 . "#f1e94b")
     (100 . "#f5f080")
     (120 . "#f6f080")
     (140 . "#41a83e")
     (160 . "#40b83e")
     (180 . "#b6d877")
     (200 . "#b7d877")
     (220 . "#b8d977")
     (240 . "#b9d977")
     (260 . "#93e0e3")
     (280 . "#72aaca")
     (300 . "#8996a8")
     (320 . "#afc4db")
     (340 . "#cfe2f2")
     (360 . "#dc8cc3"))))
 '(vc-annotate-very-old-color "#dc8cc3")
 '(view-read-only t)
 '(web-mode-enable-auto-pairing nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :foreground "Gray"))))
 '(whitespace-tab ((t (:background nil))))
 '(whitespace-trailing ((t (:foreground "magenta" :underline t :background nil)))))
