;; image-mode
(use-package image-mode :defer t
  :bind (:map image-mode-map
         ("<wheel-up>"    . image-previous-line)
         ("<wheel-down>"  . image-next-line)
         ("<wheel-right>" . image-forward-hscroll)
         ("<wheel-left>"  . image-backward-hscroll)))
