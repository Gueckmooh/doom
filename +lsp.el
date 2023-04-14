;;; +lsp.el -*- lexical-binding: t; -*-

;;;###if (modulep! lsp)
;;;###autoload
(defun lsp-load-vscode-workspace-no-remove (file)
  "Load vscode workspace from FILE."
  (interactive "fSelect file to import: ")
  (require 'lsp)
  (let ((dir (f-dirname file)))
    (->> file
         (json-read-file)
         (alist-get 'folders)
         (-map (-lambda ((&alist 'path))
                 (lsp-workspace-folders-add (expand-file-name path dir)))))))
