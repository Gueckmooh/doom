;;; tools/undo-tree/config.el -*- lexical-binding: t; -*-

(use-package! undo-tree
  :config
  (setq-default undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))
  (global-undo-tree-mode t))

(map! :leader "y" #'undo-tree-visualize)
