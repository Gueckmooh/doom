;;; +bindings.el -*- lexical-binding: t; -*-

(after! projectile
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(map! :leader
     :desc "Mark sexp" "a" #'mark-sexp
     (:prefix-map ("r" . "replace")
      :desc "Query replace" "r" #'anzu-query-replace
      :desc "Query replace regexp" "R" #'anzu-query-replace-regexp))
