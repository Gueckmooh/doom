;;; editor/clang-format/config.el -*- lexical-binding: t; -*-

(use-package! clang-format+
  :config
  (add-hook! 'c++-mode #'clang-format+-mode)
  (add-hook! 'c-mode #'clang-format+-mode))
