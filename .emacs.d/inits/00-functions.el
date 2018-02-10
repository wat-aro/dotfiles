(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun my-find-file-init-el ()
  "init.elを開く"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun my-find-file-temporary-file-directory (filename)
  "ディレクトリ `temporary-file-directory' のファイルを開く"
  (interactive
   (list (read-file-name "Find files: " temporary-file-directory)))
  (find-file filename))

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

(defun my/insert-datetime-attr ()
  "
http://ergoemacs.org/emacs/elisp_datetime.html"
  (interactive)
  (insert
   " datetime=\""
   (format-time-string "%y-%m-%dT%T")
   (let ((x (format-time-string "%z")))
     (concat (substring x 0 3) ":" (substring x 3 5)))
   "\""))
