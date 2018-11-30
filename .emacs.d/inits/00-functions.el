(defun my-find-file-init-el ()
  "init.elを開く"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun copy-buffer-name ()
  "編集中のファイル名またはバッファ名をコピペする"
  (interactive)
  (kill-new (or buffer-file-name
                (buffer-name))))

(defun orgtbl-to-gfm (table params)
  "Convert the Orgtbl mode TABLE to GitHub Flavored Markdown."
  (let* ((alignment (mapconcat (lambda (x) (if x "|--:" "|---"))
                               org-table-last-alignment ""))
         (params2
          (list
           :splice t
	   :hline (concat alignment "|")
           :lstart "| " :lend " |" :sep " | ")))
    (orgtbl-to-generic table (org-combine-plists params2 params))))

(defun split-window-right-and-balance ()
  "Split window horizontaly and balance windows."
  (interactive)
  (split-window-right)
  (balance-windows))

(defun split-window-below-and-balance ()
  "Split window vertically and balance windows."
  (interactive)
  (split-window-below)
  (balance-windows))
