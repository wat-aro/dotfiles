;; Helm
(use-package helm :defer t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (bind-key "C-x C-f" 'helm-find-files)
  (bind-key "M-x" 'helm-smex)
  (bind-key "M-X" 'helm-smex-major-mode-commands)
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

;; Swoop
(use-package helm-swoop
  :init
  (setq helm-swoop-move-to-line-cycle t)
  (bind-key "M-C-;" 'helm-swoop)
  ;; (bind-key "C-;" 'helm-multi-swoop)
  :config
  (bind-key "C-r" 'helm-previous-line helm-swoop-map)
  (bind-key "C-s" 'helm-next-line helm-swoop-map))
