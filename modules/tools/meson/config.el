;;; tools/meson/config.el -*- lexical-binding: t; -*-

(use-package! meson-mode
  :config
  (after! company-mode
    (add-hook! meson-mode #'company-mode)))
