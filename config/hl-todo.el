;;; $DOOMDIR/config/hl-todo.el -*- lexical-binding: t; -*-

(after! hl-todo
  (defcustom +hl-todo-highlight-pre-punctuation ""
    "String of characters to highlight before keywords.

Each of the characters appearing in this string is highlighted
using the same face as the preceding keyword when it directly
follows the keyword.

Characters whose syntax class is `w' (which means word),
including alphanumeric characters, cannot be used here."
    :package-version '(hl-todo . "2.0.0")
    :group 'hl-todo
    :type 'string)

  (setq +hl-todo-highlight-pre-punctuation "@"
        hl-todo-keyword-faces
        '(;; For reminders to change or add something at a later date.
          ("todo" warning bold)
          ;; For code (or code paths) that are broken, unimplemented, or slow,
          ;; and may become bigger problems later.
          ("fixme" error bold)
          ;; For code that needs to be revisited later, either to upstream it,
          ;; improve it, or address non-critical issues.
          ("review" font-lock-keyword-face bold)
          ;; For code smells where questionable practices are used
          ;; intentionally, and/or is likely to break in a future update.
          ("hack" font-lock-constant-face bold)
          ;; For sections of code that just gotta go, and will be gone soon.
          ;; Specifically, this means the code is deprecated, not necessarily
          ;; the feature it enables.
          ("deprecated" font-lock-doc-face bold)
          ;; Extra keywords commonly found in the wild, whose meaning may vary
          ;; from project to project.
          ("note" success bold)
          ("bug" error bold)
          ("XXX" font-lock-constant-face bold)))

  (defadvice! +hl-todo--setup-regexp (&rest _)
    :override #'hl-todo--setup-regexp
    (when-let ((bomb (assoc "???" hl-todo-keyword-faces)))
      ;; If the user customized this variable before we started to
      ;; treat the strings as regexps, then the string "???" might
      ;; still be present.  We have to remove it because it results
      ;; in the regexp search taking forever.
      (setq hl-todo-keyword-faces (delete bomb hl-todo-keyword-faces)))
    (setq hl-todo--regexp
          (concat (and (not (equal +hl-todo-highlight-pre-punctuation ""))
                       (concat "[" +hl-todo-highlight-pre-punctuation "]+"))
                  "\\(\\<"
                  "\\(" (mapconcat #'car hl-todo-keyword-faces "\\|") "\\)"
                  "\\>"
                  (and (not (equal hl-todo-highlight-punctuation ""))
                       (concat "[" hl-todo-highlight-punctuation "]"
                               (if hl-todo-require-punctuation "+" "*")))
                  "\\)")))
  )
