;; which-fund
(which-function-mode t)

;; Undo Tree
(use-package undo-tree
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode)
  (bind-keys :map undo-tree-map
             ("C-/" . undo-tree-undo)
             ("C-'" . undo-tree-redo)))

;; expand-region.el
(use-package expand-region :defer t
  :bind (("C-]" . er/expand-region)
         ("C-`" . er/contract-region)))

;; Visual
(bind-key "M-%" 'vr/query-replace)

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

;; ;;; init.el ends here
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
