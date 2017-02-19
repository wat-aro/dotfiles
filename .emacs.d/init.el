(package-initialize)

(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)
(use-package "pallet")
(pallet-mode t)

(init-loader-load "~/.emacs.d/inits")

(server-start)
(init-open-recentf)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(coffee-indent-like-python-mode t)
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("bdaab014ec6785f64b72efbea80808b762d8971247aacf2ffc6b76a39b9ed97c" default)))
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function nil)
 '(flycheck-idle-change-delay 1.0)
 '(helm-ff-file-compressed-list (quote ("epub" "gz" "bz2" "zip" "7z" "/backup")))
 '(inf-ruby-console-rails-default-implementation "pry")
 '(inf-ruby-default-implementation "pry")
 '(inf-ruby-eval-binding "Pry.toplevel_binding" t)
 '(js-indent-level 2)
 '(key-chord-two-keys-delay 0.01 t)
 '(markdown-indent-on-enter nil)
 '(markdown-make-gfm-checkboxes-buttons nil)
 '(open-junk-file-directory "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S." t)
 '(open-junk-file-format "~/Documents/junk/%Y/%m/%Y-%m-%d-%H%M%S." t)
 '(package-selected-packages
   (quote
    (terraform-mode ac-haskell-process flycheck-haskell haskell-mode helm-git-grep smart-newline yasnippet yard-mode yaml-mode which-key wgrep-ag web-mode w3m volatile-highlights visual-regexp use-package undo-tree tern-auto-complete sticky smartrep smartparens slim-mode scss-mode sass-mode ruby-end ruby-electric ruby-block rubocop robe recentf-ext projectile-rails prodigy popwin php-mode paredit pallet open-junk-file nyan-prompt nyan-mode nodejs-repl multiple-cursors multi-term markdown-mode magit-find-file magic-filetype key-chord init-open-recentf init-loader idle-highlight-mode htmlize helm-swoop helm-smex helm-projectile helm-migemo helm-gtags helm-ghq helm-ag hamburg-theme gotham-theme gitignore-mode flycheck-ocaml flycheck-elixir flycheck-cask flatland-theme flatland-black-theme expand-region exec-path-from-shell enh-ruby-mode emmet-mode elscreen elisp-slime-nav drag-stuff direx dired-k coffee-mode clues-theme beacon anzu annotate ag ac-slime ac-js2 ac-alchemist)))
 '(parens-require-spaces nil)
 '(projectile-completion-system (quote helm))
 '(recentf-auto-cleanup 600)
 '(recentf-auto-save-timer [nil 0 30 0 t recentf-save-list nil idle 0])
 '(recentf-exclude
   (quote
    ("/recentf" "/elpa/" "/elisps/" "\\'/tmp/" "/\\.git/" "/\\.cask/" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores")))
 '(recentf-max-saved-items 2000)
 '(rspec-use-rake-when-possible nil)
 '(show-paren-delay 0)
 '(tab-width 2)
 '(terraform-indent-level 4)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(view-read-only t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
