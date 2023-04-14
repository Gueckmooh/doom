;;; tools/fci-rule/config.el -*- lexical-binding: t; -*-


;; Display fill column indicator, i.e., the line that tels people that
;; they are doing wrong with their very long line
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
;; Make it look less aggressive to the eye
(set-face-attribute 'fill-column-indicator nil :inherit 'font-lock-comment-face
                    :foreground "#6c6979")
