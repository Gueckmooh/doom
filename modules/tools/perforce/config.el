;;; tools/perforce/config.el -*- ledical-binding: t; -*-

(use-package! p4
  :commands
  (p4-opened
   p4-add
   p4-revert
   p4-edit
   p4-diff
   p4-ediff
   p4-change))

(map! :leader
      :desc "p4 opened" "C-p o" #'p4-opened
      :desc "p4 add file" "C-p a" #'p4-add
      :desc "p4 revert file" "C-p r" #'p4-revert
      :desc "p4 edit file" "C-p e" #'p4-edit
      :desc "p4 diff" "C-p =" #'p4-diff)

(undefine-key! "C-x p")

(map! "C-x p o" #'p4-opened
      "C-x p a" #'p4-add
      "C-x p r" #'p4-revert
      "C-x p e" #'p4-edit
      "C-x p =" #'p4-diff)
