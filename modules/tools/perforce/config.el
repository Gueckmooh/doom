;;; tools/perforce/config.el -*- lexical-binding: t; -*-

(use-package! p4
  :commands
  (p4-opened
   p4-add
   p4-revert
   p4-edit
   p4-diff
   p4-ediff
   p4-change))

(map! :localleader
      :desc "p4 opened" "p o" #'p4-opened
      :desc "p4 add file" "p a" #'p4-add
      :desc "p4 revert file" "p r" #'p4-revert
      :desc "p4 edit file" "p e" #'p4-edit
      :desc "p4 diff" "p =" #'p4-diff)

(undefine-key! "C-x p")

(map! "C-x p o" #'p4-opened
      "C-x p a" #'p4-add
      "C-x p r" #'p4-revert
      "C-x p e" #'p4-edit
      "C-x p =" #'p4-diff)

(add-to-list 'command-switch-alist '("-p4diff" . command-line-p4diff))
(add-to-list 'command-switch-alist '("-p4merge" . command-line-p4merge))
