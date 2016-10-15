;;; Elixir
(require 'elixir-mode)
(require 'alchemist)
(require 'flycheck-elixir)
(add-to-list 'elixir-mode-hook
             'ac-alchemist-setup)

(sp-with-modes '(elixir-mode)
  (sp-local-pair "fn" "end"
         :when '(("SPC" "RET"))
         :actions '(insert navigate))
  (sp-local-pair "do" "end"
         :when '(("SPC" "RET"))
         :post-handlers '(sp-ruby-def-post-handler)
         :actions '(insert navigate)))
