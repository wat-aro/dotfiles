(use-package proof-general :defer t)

(use-package company-coq :defer t
  :hook
  (coq . company-coq-mode))
