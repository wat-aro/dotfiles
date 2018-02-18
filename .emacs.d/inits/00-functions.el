(defun my-find-file-init-el ()
  "init.elを開く"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun copy-buffer-name ()
  "編集中のファイル名またはバッファ名をコピペする"
  (interactive)
  (kill-new (or buffer-file-name
                (buffer-name))))
