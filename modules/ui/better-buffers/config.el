;;; ui/better-buffers/config.el -*- lexical-binding: t; -*-

(use-package! ace-jump-mode
  :config
  (map! "C-c <" #'evil-ace-jump-char-mode
        "C-c SPC" #'evil-ace-jump-line-mode)

  (map! :leader "<" #'evil-ace-jump-char-mode
        :leader ">" #'evil-ace-jump-line-mode))

(use-package! buffer-move
  :commands (buf-move-up buf-move-down buf-move-left buf-move-right)
  :bind
  ("<C-S-up>" . buf-move-up)
  ("<C-S-down>" . 'buf-move-down)
  ("<C-S-left>" . buf-move-left)
  ("<C-S-right>" . buf-move-right))
