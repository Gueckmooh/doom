;;; config/general/config.el -*- lexical-binding: t; -*-

(when (modulep! +lsp)
  (load! "+lsp"))

(when (modulep! +bindings)
  (load! "+bindings"))
