;;; migemo
(use-package migemo
  :custom
  (migemo-command "cmigemo")
  (migemo-options '("-q" "--emacs"))
  (migemo-dictionary "/usr/local/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")
  (migemo-user-dictionary nil)
  (migemo-regex-dictionary nil)
  (migemo-coding-system 'utf-8)
  :init
  (load-library "migemo")
  (migemo-init))

;; Helm
(use-package helm :defer t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (helm-mode t)
  (helm-migemo-mode 1)
  (semantic-mode 1)
  :custom
  (helm-split-window-in-side-p t)
  (helm-ff-search-library-in-sexp t)
  (helm-scroll-amount 8)
  (helm-ff-file-name-history-use-recentf t)
  (helm-echo-input-in-header-line t)
  (helm-for-files-preferred-list '(helm-source-buffers-list
                                   helm-source-recentf
                                   helm-source-bookmarks
                                   helm-source-file-cache
                                   helm-source-files-in-current-dir
                                   helm-source-locate
                                   helm-source-ghq))
  :bind (("C-x C-f" . helm-find-files)
         ("M-x"     . helm-M-x)
         ("C-;"     . helm-mini)
         :map helm-map
         ("C-i" . helm-execute-persistent-action)
         ("C-h" . delete-backward-char)
         ("C-z" . helm-select-action)))

(use-package helm-ghq
  :bind
  ("C-x f" . helm-ghq))

;; Helm-Ag
(use-package helm-ag
  :custom
  (helm-ff-file-compressed-list '("epub" "gz" "bz2" "zip" "7z" "/backup"))
  :bind
  ("C-M-:" . helm-ag))

;; Helm-Git-Grep
(use-package helm-git-grep
  :bind
  ("C-:" . helm-git-grep))

;; Swoop
(use-package helm-swoop
  :init
  ;; (setq helm-swoop-move-to-line-cycle t)
  :bind (("C-M-;" . helm-swoop)
         :map helm-swoop-map
         ("C-r" . helm-previous-line)
         ("C-s" . helm-next-line)))

(use-package helm-tramp
  :bind
  ("C-x M-f" . helm-tramp))

(helm-descbinds-install)
