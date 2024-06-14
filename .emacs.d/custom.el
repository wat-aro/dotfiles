(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(enable-remote-dir-locals t)
 '(js-indent-level 2)
 '(parens-require-spaces nil)
 '(safe-local-variable-values
    '((whitespace-line-column . 80)
       (cargo-process--custom-path-to-bin . "/usr/local/cargo/bin/cargo")
       (rspec-spec-command . "bundle exec rspec")
       (rspec-docker-command . "docker-compose run --rm")))
 '(show-paren-delay 0)
 '(uniquify-buffer-name-style 'post-forward-angle-brackets nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4"))) nil "Customized with leaf in `doom-themes' block at `/home/wat-aro/.emacs.d/init.el'")
 '(line-number ((t (:inherit default :foreground "dark gray" :strike-through nil :underline nil :slant normal :weight normal))))
 '(whitespace-style (face trailing tabs space-mark tab-mark) nil "Customized with leaf in `whitespace' block at `/home/wat-aro/.emacs.d/init.el'")
 '(whitespace-trailing ((t (:foreground "magenta" :underline t :background nil))) nil "Customized with leaf in `whitespace' block at `/home/wat-aro/.emacs.d/init.el'"))
