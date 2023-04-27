;;; tools/undo-tree/config.el -*- lexical-binding: t; -*-

(use-package! undo-tree
  :config
  (setq-default undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))
  (setq-default undo-tree-enable-undo-in-region nil)
  (global-undo-tree-mode t))

(map! :leader "U" #'undo-tree-visualize)
