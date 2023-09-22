;;; config/undo.el -*- lexical-binding: t; -*-
;;;###if (modulep! :emacs undo +tree)

(map! :leader "U" #'undo-tree-visualize)
(map! :n "U" #'undo-tree-visualize)
(after! undo-tree
  (setq-default undo-tree-visualizer-diff nil))
