;;; migemo
(use-package migemo
  :init
  (custom-set-variables '(migemo-command "cmigemo")
                        '(migemo-options '("-q" "--emacs"))
                        '(migemo-dictionary "/usr/local/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")
                        '(migemo-user-dictionary nil)
                        '(migemo-regex-dictionary nil)
                        '(migemo-coding-system 'utf-8))
  (load-library "migemo")
  (migemo-init))

;; Helm
(use-package helm :defer t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (helm-mode t)
  (helm-migemo-mode 1)
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
        ;; helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t)
  :bind (("C-x C-f" . helm-find-files)
         ("M-x" . helm-smex)
         ("C-;" . helm-mini))
  :config
  (bind-keys :map helm-map
             ("C-i" . helm-execute-persistent-action)
             ("C-h" . delete-backward-char)
             ("C-z" . helm-select-action)))

(custom-set-variables '(helm-for-files-preferred-list
                        '(helm-source-buffers-list helm-source-recentf helm-source-bookmarks helm-source-file-cache helm-source-files-in-current-dir helm-source-locate helm-source-ghq)))

(use-package helm-ghq
  :bind
  ("C-x f" . helm-ghq))

;; Helm-Ag
(custom-set-variables '(helm-ff-file-compressed-list '("epub" "gz" "bz2" "zip" "7z" "/backup")))
(bind-key "C-M-:" 'helm-ag)

;; Helm-Git-Grep
(bind-key "C-:" 'helm-git-grep)

;; Swoop
(use-package helm-swoop
  :init
  ;; (setq helm-swoop-move-to-line-cycle t)
  :bind
  ("C-M-;" . helm-swoop)
  ;; ("C-x C-M-;" . helm-multi-swoop)
  :config
  (bind-keys :map helm-swoop-map
             ("C-r" . helm-previous-line)
             ("C-s" . helm-next-line)))

(use-package helm-tramp
  :bind
  ("C-x M-f" . helm-tramp))
