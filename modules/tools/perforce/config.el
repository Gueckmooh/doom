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

(map! :leader :desc "p4-opened" "C-p o" :e "C-x p o" #'p4-opened)
(map! :leader :desc "p4-add" "C-p a" :e "C-x p a" #'p4-add)
(map! :leader :desc "p4-revert" "C-p r" :e "C-x p r" #'p4-revert)
(map! :leader :desc "p4-edit" "C-p e" :e "C-x p e" #'p4-edit)
(map! :leader :desc "p4-diff" "C-p =" :e "C-x p =" #'p4-diff)
