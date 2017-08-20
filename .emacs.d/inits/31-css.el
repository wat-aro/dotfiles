;; Emmet-mode
(use-package emmet-mode :defer t
  :init
  (add-hook 'web-mode-hook  'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  :config
  (bind-key "C-c j" 'emmet-expand-line emmet-mode-keymap)
  (bind-key "C-j" nil emmet-mode-keymap))

(use-package scss-mode
  ;; :init (add-hook 'scss-mode-hook
  ;;                 '(lambda() (scss-custom)))
  :mode ("\\.scss$" . scss-mode)
  :init
  (custom-set-variables
   '(css-indent-offset 2)
   '(scss-compile-at-save nil)))
