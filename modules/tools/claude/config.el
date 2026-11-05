;;; tools/claude/config.el -*- lexical-binding: t; -*-

(use-package! claude-code-ide
  :commands (claude-code-ide claude-code-ide-menu)
  :config
  ;; ghostel keeps the whole inline transcript scrollable (vterm drops it on redraws)
  (setq claude-code-ide-terminal-backend 'ghostel)
  ;; The xref apropos MCP tool calls `apropos-parse-pattern' without loading apropos
  (require 'apropos)
  (claude-code-ide-emacs-tools-setup))

;; Bind in Doom's own "open" prefix map: `:config default' loads after this
;; module and rebinds SPC o to `doom-leader-open-map', which would drop a key
;; bound under a plain "o" prefix
(map! :leader
      (:prefix-map ("o" . "open")
       :desc "Claude Code" "c" #'claude-code-ide-menu))

(use-package! evil-ghostel
  :when (modulep! :editor evil)
  :hook (ghostel-mode . evil-ghostel-mode))

;; Scroll Claude Code's transcript from evil normal state.  Claude Code's
;; fullscreen TUI keeps its own scrollback (the ghostel buffer only holds the
;; visible screen), so these keys are sent to the terminal instead of
;; scrolling the Emacs buffer.  Insert state is left alone: C-b there still
;; backgrounds the running task in Claude Code.
;;
;; C-u / C-d and j / k need extra bindings in the "Scroll" context of
;; ~/.claude/keybindings.json, Claude Code only binds them to other keys
;; (half pages) or to the mouse wheel (lines) by default:
;;
;;   "meta+pageup": "scroll:halfPageUp",
;;   "meta+pagedown": "scroll:halfPageDown",
;;   "ctrl+meta+up": "scroll:lineUp",
;;   "ctrl+meta+down": "scroll:lineDown",
(defun +claude-ghostel--send (key &optional mods)
  "Return a command sending KEY with MODS to the ghostel terminal."
  (lambda () (interactive) (ghostel--send-encoded key (or mods ""))))

(define-minor-mode +claude-ghostel-scroll-mode
  "Scroll Claude Code's transcript with evil normal state keys."
  :keymap (make-sparse-keymap))

(map! :map +claude-ghostel-scroll-mode-map
      :n "C-b" (+claude-ghostel--send "prior")             ; scroll:pageUp
      :n "C-f" (+claude-ghostel--send "next")              ; scroll:pageDown
      :n "C-u" (+claude-ghostel--send "prior" "meta")      ; scroll:halfPageUp
      :n "C-d" (+claude-ghostel--send "next" "meta")       ; scroll:halfPageDown
      :n "j"   (+claude-ghostel--send "down" "ctrl,meta")  ; scroll:lineDown
      :n "k"   (+claude-ghostel--send "up" "ctrl,meta")    ; scroll:lineUp
      :n "gg"  (+claude-ghostel--send "home" "ctrl")       ; scroll:top
      :n "G"   (+claude-ghostel--send "end" "ctrl"))       ; scroll:bottom

;; Called by claude-code-ide in each ghostel session buffer, once
;; `ghostel-mode' and `evil-ghostel-mode' are set up (internal function).
(defadvice! +claude-ghostel-enable-scroll-a ()
  :after #'claude-code-ide--apply-ghostel-evil-escape
  (+claude-ghostel-scroll-mode 1))

(defun +claude-code-ide--position (pos)
  "Return POS as the 0-based line/character alist Claude Code expects."
  (save-excursion
    (goto-char pos)
    `((line . ,(1- (line-number-at-pos)))
      (character . ,(- pos (line-beginning-position))))))

;; claude-code-ide sends 1-based positions, and in evil visual line state the
;; raw region, which stops at the cursor instead of covering whole lines.
(defadvice! +claude-code-ide-current-selection-a ()
  :override #'claude-code-ide-mcp--get-current-selection
  (pcase-let ((`(,beg . ,end)
               (cond ((and (bound-and-true-p evil-local-mode) (evil-visual-state-p))
                      (let ((range (evil-visual-range)))
                        (cons (evil-range-beginning range) (evil-range-end range))))
                     ((use-region-p) (cons (region-beginning) (region-end)))
                     (t (cons (point) (point))))))
    `((text . ,(buffer-substring-no-properties beg end))
      (filePath . ,(or (buffer-file-name) ""))
      (selection . ((start . ,(+claude-code-ide--position beg))
                    ;; A line-wise range ends at the start of the next line
                    (end . ,(+claude-code-ide--position
                             (if (and (> end beg)
                                      (save-excursion (goto-char end) (bolp)))
                                 (1- end)
                               end))))))))
