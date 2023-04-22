;;; config/general/config.el -*- lexical-binding: t; -*-

(after! projectile
  (add-to-list 'projectile-globally-ignored-directories "*.ccls-cache"))


(when (modulep! +lsp)
  (load! "+lsp"))

(when (modulep! +bindings)
  (load! "+bindings"))

(when (modulep! +hl-todo)
  (load! "+hl-todo"))
