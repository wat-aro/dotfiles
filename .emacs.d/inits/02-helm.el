;; Helm
(use-package helm :defer t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (helm-mode t)
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t)
  :bind (("C-x C-f" . helm-find-files)
         ("M-x" . helm-smex)
         ("M-X" . helm-smex)
         ("C-;" . helm-mini))
  :config
  (bind-keys :map helm-map
             ("C-i" . helm-execute-persistent-action)
             ("C-h" . delete-backward-char)
             ("C-z" . helm-select-action)))

(add-to-list 'helm-for-files-preferred-list 'helm-source-ghq)
(add-to-list 'exec-path "/home/wat-aro/golang/bin")
(define-key global-map (kbd "C-x f")     'helm-ghq)

;; Helm-ag
(custom-set-variables '(helm-ff-file-compressed-list '("epub" "gz" "bz2" "zip" "7z" "/backup")))
(bind-key "C-M-:" 'helm-ag)

(bind-key "C-:" 'helm-git-grep)

;; Swoop
(use-package helm-swoop
  :init
  (setq helm-swoop-move-to-line-cycle t)
  (bind-key "M-C-;" 'helm-swoop)
  ;; (bind-key "C-;" 'helm-multi-swoop)
  :config
  (bind-key "C-r" 'helm-previous-line helm-swoop-map)
  (bind-key "C-s" 'helm-next-line helm-swoop-map))
