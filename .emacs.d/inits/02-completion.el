(use-package ivy
  :init
  (ivy-mode t)
  :custom
  (ivy-height 20)
  :bind
  ("C-c C-r" . ivy-resume)
  ("<f6>" . ivy-resume))

(setq enable-recursive-minibuffers t)

(use-package counsel
  :init
  (counsel-mode t)
  :bind
  ("C-c g" . counsel-git)
  ("C-c j" . counsel-git-grep)
  ("C-c k" . counsel-ag)
  ("C-c o" . counsel-locate)
  ("C-s-o" . counsel-rhythmbox)
  ("C-;"   . counsel-switch-buffer)
  ("C-:"   . counsel-switch-buffer-other-window))


(use-package swiper
  :bind
  ("C-s" . swiper))

(straight-use-package
 '(ivy-ghq :type git :host github :repo "analyticd/ivy-ghq"))
(use-package ivy-ghq
  :custom
  (ivy-ghq-short-list t)
  :bind
  ("C-x f" . ivy-ghq-open))

(use-package counsel-tramp
  :bind
  ("C-x M-f" . counsel-tramp))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(require 'cl-lib)
(defun evenp (integer) (cl-evenp integer))

(use-package ivy-rich
  :ensure t
  :init (ivy-rich-mode 1)
  :custom
  (ivy-rich-path-style 'abbrev)
  ;; :config
  ;; (ivy-rich-modify-column 'ivy-switch-buffer
  ;;   'ivy-rich-switch-buffer-major-mode
  ;;   '(:width 20))
  )
