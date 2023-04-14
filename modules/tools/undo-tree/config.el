;;; tools/undo-tree/config.el -*- lexical-binding: t; -*-

(use-package! undo-tree
  :ensure t
  :demand t
  :config
  (setq-default undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (global-undo-tree-mode t))

(map! :n "u" #'undo-tree-visualize)
