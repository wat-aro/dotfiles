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
  ("C-s-o" . counsel-rhythmbox))


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

(use-package counsel-tramp)
