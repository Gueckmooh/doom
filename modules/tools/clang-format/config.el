;;; tools/clang-format/config.el -*- lexical-binding: t; -*-

(use-package! clang-format+
  :defer t
  :hook
  (c-mode . clang-format+-mode)
  (c++-mode . clang-format+-mode))
