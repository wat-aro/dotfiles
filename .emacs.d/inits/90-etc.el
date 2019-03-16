;; which-fund
(which-function-mode t)

;; Undo Tree
(use-package undo-tree
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode)
  :bind
  (:map undo-tree-map
   ("C-/" . undo-tree-undo)
   ("C-'" . undo-tree-redo)))

;; expand-region.el
(use-package expand-region :defer t
  :bind (("C-@" . er/expand-region)
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
  :custom
  (wgrep-auto-save-buffer t)  ; 編集完了と同時に保存
  (wgrep-enable-key "r")      ; "r" キーで編集モードに
  (ag-highlight-search t)
  (ag-reuse-buffers t)
  (wgrep-auto-save-buffer t)
  (wgrep-enable-key "r")
  :hook
  (ag-mode . (lambda ()
               (use-package wgrep-ag)
               (wgrep-ag-setup)))
  :config
  (use-package wgrep-ag)
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
(custom-set-variables '(nyan-bar-length 16))
(nyan-mode t)

(use-package selected
  :init
  (setq selected-minor-mode-override t)
  (selected-global-mode 1)
  :config
  (setq selected-org-mode-map (make-sparse-keymap))
  :bind
  (:map selected-org-mode-map
   ("t" . org-table-convert-region)
   :map selected-keymap
   ("q" . selected-off)
   ("u" . upcase-region)
   ("d" . downcase-region)
   ("w" . count-words-region)
   ("m" . apply-macro-to-region-lines)))

(use-package generic-x)
