;;; tools/perforce/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun command-line-p4diff (switch)
  "Use emacs as a p4 diff utility. SWITCH is unused."
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))

;;;###autoload
(defun command-line-p4merge (switch)
  "Use emacs as p4 merge utility. SWITCH is unused."
  (let ((base (pop command-line-args-left))
        (sccs (pop command-line-args-left))
        (mine (pop command-line-args-left))
        (merg (pop command-line-args-left)))
    (ediff-merge-with-ancestor sccs mine base () merg)))

