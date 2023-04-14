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

(map! :leader "C-p o" #'p4-opened
      :leader "C-p a" #'p4-add
      :leader "C-p r" #'p4-revert
      :leader "C-p e" #'p4-edit
      :leader "C-p =" #'p4-diff)

(undefine-key! "C-x p")

(map! "C-x p o" #'p4-opened
      "C-x p a" #'p4-add
      "C-x p r" #'p4-revert
      "C-x p e" #'p4-edit
      "C-x p =" #'p4-diff)
