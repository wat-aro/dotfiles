(use-package popwin
  :init
  (setq display-buffer-function 'popwin:display-buffer)
  :config
  (when (fboundp 'popwin:w3m-browse-url)
    (setq browse-url-browser-function 'popwin:w3m-browse-url))
  (setq popwin:special-display-config
        (append popwin:special-display-config
                '(("*w3m*")
                  ("*slime-apropos*")
                  ("*slime-macroexpansion*")
                  ("*slime-description*")
                  ("*slime-compilation*" :noselect t)
                  ("*slime-xref*")
                  (slime-connection-list-mode)
                  (sldb-mode :height 40 :stick t)
                  slime-repl-mode
                  slime-connection-list-mode
                  (direx:direx-mode :position left :width 25 :dedicated t)
                  ("*quickrun*")
                  (dired-mode :position top)
                  ("*Shell Command Output*")
                  (compilation-mode :noselect t)))))
