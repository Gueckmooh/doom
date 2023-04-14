;;; tools/perforce/config.el -*- lexical-binding: t; -*-

(use-package! p4
  :commands
  (p4-opened
   p4-add
   p4-revert
   p4-edit
   p4-diff
   p4-ediff
   p4-change)
