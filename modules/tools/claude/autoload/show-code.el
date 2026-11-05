;;; tools/claude/autoload/show-code.el -*- lexical-binding: t; -*-

;; The show_code MCP tool, registered in config.el: Claude Code shows a
;; range of a file to the user, highlighted.  The highlight stays while the
;; user scrolls, and is cleared by the next call, by the first edit of its
;; buffer, or by escape in its buffer.

(defface +claude-show-code-face
  '((t :inherit highlight :extend t))
  "Face of the code range shown by Claude Code's show_code tool."
  :group 'claude-code-ide)

(defvar +claude-show-code--overlay nil
  "Overlay of the code range Claude Code is showing, or nil.")

;;;###autoload
(defun +claude-show-code-clear ()
  "Remove the highlight of the code range Claude Code is showing."
  (interactive)
  (when-let* ((ov +claude-show-code--overlay)
              (buffer (overlay-buffer ov)))
    (with-current-buffer buffer
      (remove-hook 'after-change-functions #'+claude-show-code--after-change-h t))
    (delete-overlay ov))
  (remove-hook 'doom-escape-hook #'+claude-show-code--escape-h)
  (setq +claude-show-code--overlay nil))

(defun +claude-show-code--after-change-h (&rest _)
  "Clear the highlight once its buffer is modified: the lines may have moved."
  (+claude-show-code-clear))

(defun +claude-show-code--escape-h ()
  "Clear the highlight when escape is pressed in the buffer showing it."
  (when (and +claude-show-code--overlay
             (eq (overlay-buffer +claude-show-code--overlay) (current-buffer)))
    (+claude-show-code-clear)
    t))

(defun +claude-show-code--window (claude-window)
  "Return the window to show code in, next to CLAUDE-WINDOW.
Reuse the most recently used window of its frame that is neither
CLAUDE-WINDOW, a side window nor a dedicated window, so that a small
window is replaced rather than split; split only when there is none."
  (let* ((frame (if claude-window (window-frame claude-window) (selected-frame)))
         (candidates (seq-remove (lambda (w)
                                   (or (eq w claude-window)
                                       (window-parameter w 'window-side)
                                       (window-dedicated-p w)))
                                 (window-list frame 'nomini))))
    (if candidates
        (car (sort candidates :key #'window-use-time :reverse t))
      (let ((window (or claude-window (selected-window))))
        (split-window window nil
                      (if (>= (window-total-width window) 160) 'left 'above))))))

(defun +claude-show-code--range (start-line end-line start-column end-column)
  "Return the (BEG . END) positions of a range of the current buffer.
Lines are 1-based and columns 0-based.  Without END-COLUMN, the range
ends at the start of the next line, so that the face extends to the
window edge."
  (save-restriction
    (widen)
    (let ((last-line (line-number-at-pos (point-max))))
      (unless (<= 1 start-line end-line last-line)
        (error "Invalid line range %d-%d: the file has %d lines"
               start-line end-line last-line))
      (save-excursion
        (goto-char (point-min))
        (forward-line (1- start-line))
        (let ((beg (min (+ (point) (or start-column 0)) (pos-eol))))
          (forward-line (- end-line start-line))
          (cons beg (if end-column
                        (min (+ (point) end-column) (pos-eol))
                      (forward-line 1)
                      (point))))))))

;;;###autoload
(defun +claude-show-code (file-path start-line &optional end-line start-column end-column)
  "Show FILE-PATH from START-LINE to END-LINE to the user, highlighted.
The file is shown next to the Claude Code window and selected; the
range is centered when it fits the window, otherwise it starts near
the top.  Return a short confirmation for Claude Code."
  (let* ((context (claude-code-ide-mcp-server-get-session-context))
         (default-directory (or (plist-get context :project-dir) default-directory))
         (file (expand-file-name file-path))
         (end-line (or end-line start-line))
         (claude-buffer (plist-get context :buffer))
         (claude-window (and (buffer-live-p claude-buffer)
                             (get-buffer-window claude-buffer t))))
    (unless (file-readable-p file)
      (error "Cannot read %s" file))
    (let* ((buffer (find-file-noselect file))
           (range (with-current-buffer buffer
                    (+claude-show-code--range start-line end-line
                                              start-column end-column)))
           (window (+claude-show-code--window claude-window)))
      (+claude-show-code-clear)
      (with-current-buffer buffer
        (setq +claude-show-code--overlay (make-overlay (car range) (cdr range)))
        (overlay-put +claude-show-code--overlay 'face '+claude-show-code-face)
        (add-hook 'after-change-functions #'+claude-show-code--after-change-h nil t))
      (add-hook 'doom-escape-hook #'+claude-show-code--escape-h)
      (set-window-buffer window buffer)
      (select-window window)
      (select-frame-set-input-focus (window-frame window))
      (with-current-buffer buffer
        (goto-char (car range))
        (let ((height (window-body-height window))
              (count (1+ (- end-line start-line))))
          (recenter (if (<= count height) (/ (- height count) 2) 2))))
      (if (= start-line end-line)
          (format "Showing %s:%d" file start-line)
        (format "Showing %s:%d-%d" file start-line end-line)))))
