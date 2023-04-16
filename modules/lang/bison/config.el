;;; lang/bison/config.el -*- lexical-binding: t; -*-

(use-package! bison-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.l\\'" . flex-mode))
  (add-to-list 'auto-mode-alist '("\\.ll\\'" . flex-mode))
  (add-to-list 'auto-mode-alist '("\\.y\\'" . bison-mode))
  (add-to-list 'auto-mode-alist '("\\.yy\\'" . bison-mode)))
