;;; +bindings.el -*- lexical-binding: t; -*-

;; Make C-h be backspace in emacs mode
(global-set-key (kbd "C-h") #'backward-delete-char-untabify)

(map! :ge "<f1>" #'help-command
      :ge "M-p" #'backward-paragraph
      :ge "M-n" #'forward-paragraph
      :ge "M-y" #'helm-show-kill-ring
      :ge "C-x C-k c" #'kmacro-call-macro
      :ge "C-x !" #'next-error
      (:when (modulep! :tools magit)
       :ge "C-c g" #'magit-status))

(map! :leader
      :desc "Mark sexp" "a" #'mark-sexp
      :desc "Show helm kill ring" "y" #'helm-show-kill-ring
      (:prefix-map ("r" . "replace")
       :desc "Query replace" "r" #'anzu-query-replace
       :desc "Query replace regexp" "R" #'anzu-query-replace-regexp)
      (:when (modulep! :completion helm)
       :desc "Jump to mark" "s M" #'helm-mark-ring))

(map! :i
      "C-d" #'delete-char
      "C-h" #'backward-delete-char-untabify)

;; Deactivate C-h opening the documentation when company is active so that I can
;; errase things
(map! :map company-active-map
      "C-h" nil
      "C-d" nil)

(after! projectile
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(after! ivy
  (map! :map ivy-minibuffer-map
        "C-j" #'ivy-next-line
        "C-k" #'ivy-previous-line
        "<escape>" #'abort-recursive-edit))
