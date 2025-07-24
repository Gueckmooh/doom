;;; $DOOMDIR/config/lsp.el -*- lexical-binding: t; -*-
;;;###if (modulep! lsp)

(after! lsp-mode
  (setq-default lsp-lens-enable nil)
  (setq-default lsp-inlay-hint-enable t)
  (setq-default lsp-headerline-breadcrumb-enable t)
  ;; (setq lsp-use-plists "true")
  (setq-default lsp-ui-doc-show-with-cursor nil))

(after! company
  (map! :gei "M-i" #'company-complete-common)
  (setq-default company-minimum-prefix-length 1))

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

(after! flycheck
  (map! :leader "!" flycheck-command-map))
