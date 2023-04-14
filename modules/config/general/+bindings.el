;;; +bindings.el -*- lexical-binding: t; -*-

(after! projectile
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
