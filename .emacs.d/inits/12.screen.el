(use-package elscreen
  :init
  (custom-set-variables
   ;; プレフィクスキーはC-z
   '(elscreen-prefix-key (kbd "C-q"))
   ;; タブの先頭に[X]を表示しない
   '(elscreen-tab-display-kill-screen nil)
   ;; header-lineの先頭に[<->]を表示しない
   '(elscreen-tab-display-control nil)
   ;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
   '(elscreen-mode-to-nickname-alist
     '(("^dired-mode$" .
        (lambda ()
          (format "Dired(%s)" dired-directory)))
       ("^Info-mode$" .
        (lambda ()
          (format "Info(%s)" (file-name-nondirectory Info-current-file))))
       ("^mew-draft-mode$" .
        (lambda ()
          (format "Mew(%s)" (buffer-name (current-buffer)))))
       ("^mew-" . "Mew")
       ("^irchat-" . "IRChat")
       ("^liece-" . "Liece")
       ("^lookup-" . "Lookup")))
   '(elscreen-buffer-to-nickname-alist
     '(("[Ss]hell" . "shell")
       ("compilation" . "compile")
       ("-telnet" . "telnet")
       ("dict" . "OnlineDict")
       ("*WL:Message*" . "Wanderlust")))
   ;; タブの幅
   '(elscreen-display-tab 20)
   ;; モードラインにスクリーンナンバーを表示するか
   '(elscreen-display-screen-number nil))
  (elscreen-start)
  :bind
  ("C-<tab>"   . elscreen-next)
  ("C-S-<tab>" . elscreen-previous))
