;;; Elixir
(use-package elixir-mode
  :hook
  (elixir-mode . ac-alchemist-setup)
  :config
  (sp-with-modes '(elixir-mode)
    (sp-local-pair "fn" "end"
                   :when '(("SPC" "RET"))
                   :actions '(insert navigate))
    (sp-local-pair "do" "end"
                   :when '(("SPC" "RET"))
                   :post-handlers '(sp-ruby-def-post-handler)
                   :actions '(insert navigate))))

(require 'alchemist)
(require 'flycheck-elixir)
