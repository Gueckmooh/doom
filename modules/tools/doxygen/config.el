;;; tools/doxygen/config.el -*- lexical-binding: t; -*-

(use-package! highlight-doxygen
  :commands (highlight-doxygen-mode)
  :config
  (set-face-background 'highlight-doxygen-comment nil))

(add-hook! c++-mode #'highlight-doxygen-mode)
(add-hook! c-mode #'highlight-doxygen-mode)
(when (modulep! :lang souffle)
  (add-hook! souffle-mode #'highlight-doxygen-mode))
