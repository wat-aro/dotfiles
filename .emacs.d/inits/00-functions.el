(defun my-find-file-init-el ()
  "init.elを開く"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun copy-buffer-name ()
  "編集中のファイル名またはバッファ名をコピペする"
  (interactive)
  (kill-new (or buffer-file-name
                (buffer-name))))

(defun my-insert-datetime-simple ()
  "現在の日時を挿入する YYYY-mm-dd形式
http://ergoemacs.org/emacs/elisp_datetime.html"
  (interactive)
  (insert
   (format-time-string "%Y-%m-%d %T")))
