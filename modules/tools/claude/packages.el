;; -*- no-byte-compile: t; -*-
;;; tools/claude/packages.el

(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el")
  :pin "50a3d55262805d7207889ed429ff30da96fbf68b")
(package! ghostel)
(package! evil-ghostel)
