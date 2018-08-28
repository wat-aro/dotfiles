;; (require 'sticky)
;; (use-sticky-key ?\; sticky-alist:en)

;; (defun skk-mode-hook--unset-key ()
;;   (define-key skk-j-mode-map ";" nil))
;; (add-hook 'skk-mode-hook 'skk-mode-hook--unset-key)

;; (setq skk-byte-compile-init-file t)

;; (setq skk-user-directory "~/.emacs.d/ddskk/")
;; (setq skk-tut-file "~/.emacs.d/share/skk/SKK.tut") ;;チュートリアルファイルの場所

;; (require 'skk-autoloads)
;; ;;(require 'skk-dcomp)

;; (setq default-input-method
;;       "japanese-skk"			; (skk-mode 1)
;; ;;    "japanese-skk-auto-fill"		; (skk-auto-fill-mode 1)
;;       )

;; ;; key
;; (define-key global-map (kbd "C-c C-o") 'skk-mode)
;; (setq skk-kakutei-key (kbd "C-o"))
;; (setq mac-pass-control-to-system nil)

;; ;; user dic
;; (setq skk-jisyo-code 'utf-8)
;; (setq skk-jisyo (concat (getenv "HOME") "/Dropbox/skk/skk-jisyo-emacs.utf8"))
;; (setq skk-share-private-jisyo t)
;; (setq skk-save-jisyo-instantly t)

;; (setq skk-isearch-start-mode 'latin)

;; ;;; カナモードのときにC-oしてもひらがなモードにもどる
;; (defun my:skk-kakutei-key (arg)
;;   (interactive "P")
;;   (if skk-henkan-mode
;;       (skk-kakutei arg)
;;     (skk-j-mode-on)))

;; (add-to-list 'skk-rom-kana-rule-list
;;              '(skk-kakutei-key nil my:skk-kakutei-key))
(require 'skk)
;; skk-latin-mode for all buffers
(define-globalized-minor-mode global-skk-latin-mode skk-latin-mode skk-latin-mode-on)
(global-skk-latin-mode 1)

;; (setq skk-show-inline 'vertical)
;; (skk-show-mode)
