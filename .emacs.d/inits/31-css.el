;; Emmet-mode
(use-package emmet-mode :defer t
  :init
  (add-hook 'web-mode-hook  'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  :config
  (bind-key "C-c j" 'emmet-expand-line emmet-mode-keymap)
  (bind-key "C-j" nil emmet-mode-keymap))
