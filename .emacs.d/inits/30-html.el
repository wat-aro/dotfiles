;; Web
(defun my/web-mode-hook ()
  "Set variables for web-mode."
  (custom-set-variables
   '(web-mode-enable-auto-pairing nil))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-comment-style 2)
  (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t))

(defun sp-web-mode-is-code-context  (id action context)
  "This snippet is derived from http://web-mode.org/ ."
  (when (and (eq action 'insert)
             (not (or (get-text-property (point) 'part-side)
                      (get-text-property (point) 'block-side))))
    t))

(use-package web-mode :defer t
  :init
  (add-hook 'web-mode-hook 'my/web-mode-hook)
  (add-hook 'web-mode-hook 'emmet-mode)
  (--each '("\\.html?\\'" "\\.tpl\\'" "\\.tpl\\.xhtml\\'" "\\.ejs\\'" "\\.hbs\\'"
            "\\.html\\.erb\\'" "\\.html\\+smartphone\\.erb\\'" "\\.css?\\'"
            "\\.js\\.coffee\\.erb\\'" "\\.js\\.erb\\'" "\\.mustache\\'")
    (add-to-list 'auto-mode-alist (cons it 'web-mode)))
  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context))
  :config
  (setq web-mode-markup-indent-offset 2)
  (flycheck-mode t))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'html-tidy 'web-mode)
  (flycheck-add-mode 'css-csslint 'web-mode))

(use-package slim-mode
  :init
  (add-hook 'slim-mode-hook
            '(lambda ()
               (flycheck-mode t)))
  :mode
  ("\\.slim\\'" . slim-mode)
  ("\\.html\\.slim\\'" . slim-mode))

(use-package haml-mode
  :mode
  ("\\.haml\\'" . haml-mode)
  ("\\.html\\.haml\\'" . haml-mode))
