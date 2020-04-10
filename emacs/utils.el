;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; utilities

(defun my-edit-file-as-sudo/root ()
  "Find file as root"
  (interactive)
  (let*
      ((sudo (/= (call-process "sudo" nil nil "-n true") 0))
       (file-name
        (if (tramp-tramp-file-p buffer-file-name)
            (with-parsed-tramp-file-name buffer-file-name parsed
              (tramp-make-tramp-file-name
               (if sudo "sudo" "su")
               "root"
               parsed-host
               parsed-localname
               (let ((tramp-postfix-host-format "|")
                     (tramp-prefix-format))
                 (tramp-make-tramp-file-name
                  parsed-method
                  parsed-user
                  parsed-host
                  ""
                  parsed-hop))))
          (concat (if sudo
                      "/sudo::"
                    "/su::")
                  buffer-file-name))))
    (find-alternate-file file-name)))


(defun sh-send-line-or-region (&optional step)
  (interactive ())
  (let ((proc (get-process "shell"))
        pbuf min max command)
    (unless proc
      (let ((currbuff (current-buffer)))
        (shell)
        (switch-to-buffer currbuff)
        (setq proc (get-process "shell"))
        ))
    (setq pbuff (process-buffer proc))
    (if (use-region-p)
        (setq min (region-beginning)
              max (region-end))
      (setq min (point-at-bol)
            max (point-at-eol)))
    (setq command (concat (buffer-substring min max) "\n"))
    (with-current-buffer pbuff
      (goto-char (process-mark proc))
      (insert command)
      (move-marker (process-mark proc) (point))
      ) ;;pop-to-buffer does not work with save-current-buffer -- bug?
    (process-send-string  proc command)
    (display-buffer (process-buffer proc) t)
    (when step
      (goto-char max)
      (next-line))
    ))

(defun sh-send-line-or-region-and-step ()
  (interactive)
  (sh-send-line-or-region t))
(defun sh-switch-to-process-buffer ()
  (interactive)
  (pop-to-buffer (process-buffer (get-process "shell")) t))

(global-set-key (kbd "C-x C-t") 'sh-send-line-or-region)



;; crontab edit
(defun crontab-e ()
  (interactive)
  (with-editor-async-shell-command "crontab -e"))


;; remote connection

(defun dired-remote (name)
  "Connect to a predefined server."
  (interactive
   (list
    (completing-read "Connect to: " server-connection-alist)))
  (when (not (or (equal name "")
                 (equal name nil)))
    (dired name)))


(defun remote-avilpage ()
  (interactive)
  (dired "/ssh:ubuntu@avilpage.com:/home/ubuntu/"))


(defun is-line-empty-p ()
  "Return t if current line is empty."
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

(defun is-inside-parens-p ()
  "Return t if point is inside parens."
  (> (car (syntax-ppss)) 0))

(defun my-lispy-kill ()
  "Clean up whitespace along with lispy kill."
  (interactive)
  (if (is-line-empty-p)
      (lispy-kill)
    (if (is-inside-parens-p)
        (lispy-kill)
      (lispy-kill)
      (kill-line))))

;; remote connection
;; (defun connect-to-server ()
;;   (interactive)
;;   (dired (format  "/%s@%s:/" server-user server-host)))


;; recenter when hyperlink is clicked
(defun my-recenter-on-find-function (orig &rest args)
  (let ((result (apply orig args)))
    (when result
      (recenter 0))
    result))
(advice-add 'help-button-action :around #'my-recenter-on-find-function)


(defun delete-whole-line (&optional arg)
  "A simple wrapper around command `kill-whole-line' that respects indentation.
Passes ARG to command `kill-whole-line' when provided."
  (interactive "p")
  (kill-whole-line arg)
  (back-to-indentation))


(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun swap-numbers-symbols ()
  "Swap symbols to digits."
  (interactive)
  (define-key key-translation-map (kbd "!") (kbd "1"))
  (define-key key-translation-map (kbd "@") (kbd "2"))
  (define-key key-translation-map (kbd "#") (kbd "3"))
  (define-key key-translation-map (kbd "$") (kbd "4"))
  (define-key key-translation-map (kbd "%") (kbd "5"))
  (define-key key-translation-map (kbd "^") (kbd "6"))
  (define-key key-translation-map (kbd "&") (kbd "7"))
  (define-key key-translation-map (kbd "*") (kbd "8"))
  (define-key key-translation-map (kbd "(") (kbd "9"))
  (define-key key-translation-map (kbd ")") (kbd "0"))

  (define-key key-translation-map (kbd "1") (kbd "!"))
  (define-key key-translation-map (kbd "2") (kbd "@"))
  (define-key key-translation-map (kbd "3") (kbd "#"))
  (define-key key-translation-map (kbd "4") (kbd "$"))
  (define-key key-translation-map (kbd "5") (kbd "%"))
  (define-key key-translation-map (kbd "6") (kbd "^"))
  (define-key key-translation-map (kbd "7") (kbd "&"))
  (define-key key-translation-map (kbd "8") (kbd "*"))
  (define-key key-translation-map (kbd "9") (kbd "("))
  (define-key key-translation-map (kbd "0") (kbd ")")))

(defun swap-numbers-parens ()
  "( -> 9 and ) -> 0"
  (interactive)
  (define-key key-translation-map (kbd "(") (kbd "9"))
  (define-key key-translation-map (kbd ")") (kbd "0"))
  (define-key key-translation-map (kbd "9") (kbd "("))
  (define-key key-translation-map (kbd "0") (kbd ")")))
;; (swap-numbers-parens)


(defun current-dired ()
  (interactive)
  (dired "."))


(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))


(defun launch-separate-emacs-under-x ()
  (interactive)
  (call-process "sh" nil nil nil "-c" "emacs &"))


(defun restart-emacs ()
  (interactive)
  ;; We need the new emacs to be spawned after all kill-emacs-hooks
  ;; have been processed and there is nothing interesting left
  (add-hook 'kill-emacs-hook
            (if (display-graphic-p)
                #'launch-separate-emacs-under-x
              #'launch-separate-emacs-in-terminal)
            t)
  (kill-emacs))


(defun get-positions-of-line-or-region ()
  "Return positions (beg . end) of the current line
or region."
  (let (beg end)
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (cons beg end)))


(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated.  However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (pcase-let* ((origin (point))
               (`(,beg . ,end) (get-positions-of-line-or-region))
               (region (buffer-substring-no-properties beg end)))
    (-dotimes arg
      (lambda (n)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point))))
    (goto-char (+ origin (* (length region) arg) arg))))


(defun smart-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.
If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
                'smart-move-beginning-of-line)


(defun uncomment-sexp (&optional n)
  "Uncomment a sexp around point."
  (interactive "P")
  (let* ((initial-point (point-marker))
         (p)
         (end (save-excursion
                (when (elt (syntax-ppss) 4)
                  (re-search-backward comment-start-skip
                                      (line-beginning-position)
                                      t))
                (setq p (point-marker))
                (comment-forward (point-max))
                (point-marker)))
         (beg (save-excursion
                (forward-line 0)
                (while (= end (save-excursion
                                (comment-forward (point-max))
                                (point)))
                  (forward-line -1))
                (goto-char (line-end-position))
                (re-search-backward comment-start-skip
                                    (line-beginning-position)
                                    t)
                (while (looking-at-p comment-start-skip)
                  (forward-char -1))
                (point-marker))))
    (unless (= beg end)
      (uncomment-region beg end)
      (goto-char p)
      ;; Indentify the "top-level" sexp inside the comment.
      (while (and (ignore-errors (backward-up-list) t)
                  (>= (point) beg))
        (skip-chars-backward (rx (syntax expression-prefix)))
        (setq p (point-marker)))
      ;; Re-comment everything before it.
      (ignore-errors
        (comment-region beg p))
      ;; And everything after it.
      (goto-char p)
      (forward-sexp (or n 1))
      (skip-chars-forward "\r\n[:blank:]")
      (if (< (point) end)
          (ignore-errors
            (comment-region (point) end))
        ;; If this is a closing delimiter, pull it up.
        (goto-char end)
        (skip-chars-forward "\r\n[:blank:]")
        (when (= 5 (car (syntax-after (point))))
          (delete-indentation))))
    ;; Without a prefix, it's more useful to leave point where
    ;; it was.
    (unless n
      (goto-char initial-point))))

(defun comment-sexp--raw ()
  "Comment the sexp at point or ahead of point."
  (pcase (or (bounds-of-thing-at-point 'sexp)
             (save-excursion
               (skip-chars-forward "\r\n[:blank:]")
               (bounds-of-thing-at-point 'sexp)))
    (`(,l . ,r)
     (goto-char r)
     (skip-chars-forward "\r\n[:blank:]")
     (comment-region l r)
     (skip-chars-forward "\r\n[:blank:]"))))

(defun comment-or-uncomment-sexp (&optional n)
  "Comment the sexp at point and move past it.
If already inside (or before) a comment, uncomment instead.
With a prefix argument N, (un)comment that many sexps."
  (interactive "P")
  (if (or (elt (syntax-ppss) 4)
          (< (save-excursion
               (skip-chars-forward "\r\n[:blank:]")
               (point))
             (save-excursion
               (comment-forward 1)
               (point))))
      (uncomment-sexp n)
    (dotimes (_ (or n 1))
      (comment-sexp--raw))))


(defun upgrade-all-packages ()
  "Upgrade all packages, no questions asked."
  (interactive)
  (save-window-excursion
    (package-list-packages)
    (package-menu-mark-upgrades)
    (package-menu-execute 'no-query)))


(defun space-to-ctrl-activate ()
  "Active space2cctl."
  (interactive)
  (call-process-shell-command  "~/projects/eddie/ubuntu/bin/xcape.sh" nil 0))
(space-to-ctrl-activate)


(defun tidy-current-buffer ()
  "Tidy html"
  (interactive)
  (async-shell-command
   (format "tidy -i -m -w 160 -ashtml -utf8 %s"
           (buffer-file-name (current-buffer)))))
