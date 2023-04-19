;; -*- no-byte-compile: t; -*-
;;; lang/souffle/packages.el

(package! souffle :recipe
  (:host github
   :repo "Gueckmooh/souffle-mode"
   :branch "font-lock-enhancement"
   :files ("souffle-mode.el")))
