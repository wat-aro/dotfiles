(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

(use-package init-loader
  :init
  (init-loader-load "~/.emacs.d/inits")
  :custom
  (init-loader-show-log-after-init 'error-only))

(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(anzu-use-migemo t)
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(init-loader-show-log-after-init (quote error-only))
 '(ivy-ghq-short-list t)
 '(ivy-height 20)
 '(parens-require-spaces nil)
 '(popwin:popup-window-height 0.4)
 '(recentf-auto-save-timer [nil 0 30 0 t recentf-save-list nil idle 0])
 '(rspec-use-rake-when-possible nil)
 '(safe-local-variable-values
   (quote
    ((rspec-docker-container . "spring")
     (rspec-docker-cwd . "/usr/src/app/")
     (rspec-use-docker-when-possible . t)
     (rspec-docker-command . "docker-compose run --rm"))))
 '(show-paren-delay 0)
 '(tab-width 2)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(view-read-only t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4"))))
 '(whitespace-style (face trailing tabs space-mark tab-mark))
 '(whitespace-trailing ((t (:foreground "magenta" :underline t :background nil)))))
