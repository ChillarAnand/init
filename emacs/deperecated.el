;; deperecated code

(use-package golden-ratio
  :config
  (golden-ratio-mode 1)

  (defvar golden-ratio-selected-window
    (frame-selected-window)
    "Selected window.")

  (defun golden-ratio-set-selected-window
      (&optional window)
    "Set selected window to WINDOW."
    (setq-default
     golden-ratio-selected-window (or window (frame-selected-window))))

  (defun golden-ratio-selected-window-p
      (&optional window)
    "Return t if WINDOW is selected window."
    (eq (or window (selected-window))
        (default-value 'golden-ratio-selected-window)))

  (defun golden-ratio-maybe
      (&optional arg)
    "Run `golden-ratio' if `golden-ratio-selected-window-p' returns nil."
    (interactive "p")
    (unless (golden-ratio-selected-window-p)
      (golden-ratio-set-selected-window)
      (golden-ratio arg)))

  (add-hook 'buffer-list-update-hook #'golden-ratio-maybe)
  (add-hook 'focus-in-hook           #'golden-ratio)
  (add-hook 'focus-out-hook          #'golden-ratio))


(use-package arduino-mode
  :config
  (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
  (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t))


(use-package indium
  :config
  (add-hook 'js-mode-hook #'indium-interaction-mode))


(use-package js-comint
  :config
  (defun inferior-js-mode-hook-setup ()
    (add-hook 'comint-output-filter-functions 'js-comint-process-output))
  (add-hook 'inferior-js-mode-hook 'inferior-js-mode-hook-setup t))


(use-package paredit)


(use-package smartparens
  :config
  (sp-pair "`" "`" :wrap "C-`")
  (sp-pair "%" "%" :wrap "C-%")
  (sp-pair "<" ">" :wrap "C->")
  (defun strict-smartparens ()
    (turn-on-smartparens-strict-mode))
  (add-hook 'prog-mode-hook 'strict-smartparens))


(use-package bash-completion
  :config
  (bash-completion-setup))


(use-package multi-term
  :config
  (defun mutli-term-get-or-create-process ()
    (interactive)
    (let* ((bufname "*terminal<1>*")
           (proc (get-buffer-process bufname)))
      (when (not proc)
        (multi-term))
      (display-buffer bufname
                      nil
                      'visible)))
  :bind
  ("C-c C-t" . multi-term-get-or-create-process))


(use-package xterm-color)


(defun sh-send-line-or-region (&optional step)
  (interactive ())
  (setq process-name "*terminal<1>*")
  (let ((proc (get-process process-name))
        pbuf min max command)
    (unless proc
      (let ((currbuff (current-buffer)))
        (shell)
        (switch-to-buffer currbuff)
        (setq proc (get-process process-name))
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

(require 'sh-script)
(sh-set-shell "zsh")
(add-hook 'shell-mode-hook
          'ansi-color-for-comint-mode-on)
(define-key sh-mode-map (kbd "C-c C-c") 'sh-send-line-or-region)
(define-key sh-mode-map (kbd "<C-return>") 'sh-send-line-or-region-and-step)
(define-key sh-mode-map (kbd "C-c C-z") 'sh-switch-to-process-buffer)



(use-package prodigy
  :config

  (prodigy-define-service
    :name "0 django library"
    :tags '(appknox)
    :cwd "~/projects/library/"
    :command "bash"
    :args '("scripts/start_server.sh")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "avilpage serve"
    :cwd "~/projects/python/avilpage/"
    :command "nikola"
    :args '("auto")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  :bind
  ;; ("C-x C-p" . prodigy)
  )


(defun prodigy-begin ()
  (interactive)
  (prodigy)
  (with-current-buffer "*prodigy*"
    (prodigy-mark-all)
    (prodigy-start)
    (prodigy-unmark-all)))


(use-package salt-mode)



(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))


(use-package ember-mode
  :config
  (add-hook 'js-mode-hook (lambda () (ember-mode t)))
  (add-hook 'web-mode-hook (lambda () (ember-mode t))))


(use-package slim-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.emblem\\'" . slim-mode)))


(use-package magithub
  :after magit
  :config (magithub-feature-autoinject t))

(use-package magit-gh-pulls
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls))


(use-package multi-term
  :config
  (setq multi-term-program "/bin/zsh")
  (bind-key "C-c C-t" 'multi-term)
  (bind-key "C-c C-n" 'multi-term-next)
  (bind-key "C-c C-p" 'multi-term-prev))


(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))



;; (use-package zenburn-theme)


;; (use-package solarized-theme)
;; (deftheme solarized-dark "The dark variant of the Solarized colour theme")
;; (create-solarized-theme 'dark 'solarized-dark)
;; (provide-theme 'solarized-dark)


;; (setq mode-line-format
;;       '("%e" mode-line-front-space mode-line-mule-info mode-line-client
;;         mode-line-modified mode-line-remote mode-line-frame-identification
;;         mode-line-buffer-identification
;;         (vc-mode vc-mode)
;;         sml/pre-modes-separator mode-line-modes
;;         sml/pos-id-separator mode-line-position))



(use-package openwith
  :init
  (openwith-mode t)
  (setq large-file-warning-threshold 500000000)
  (setq openwith-associations
        (list (list (openwith-make-extension-regexp '("pdf"))
                    "evince" '(file))
              (list (openwith-make-extension-regexp '("flac" "mp3" "wav" "webm" "mp4"))
                    "vlc" '(file))
              (list (openwith-make-extension-regexp
                     '("avi" "flv" "mov" "mp4" "mkv" "mpeg" "mpg" "ogg" "wmv"))
                    "vlc" '(file))
              (list (openwith-make-extension-regexp '("bmp" "jpeg" "jpg" "png"))
                    "ristretto" '(file))
              (list (openwith-make-extension-regexp '("doc" "docx" "odt"))
                    "libreoffice" '("--writer" file))
              (list (openwith-make-extension-regexp '("ods" "xls" "xlsx"))
                    "libreoffice" '("--calc" file))
              (list (openwith-make-extension-regexp '("odp" "pps" "ppt" "pptx"))
                    "libreoffice" '("--impress" file))
              )))


;; swiper for search
;; (use-package ivy)
;; (use-package swiper-helm
;;   :config
;;   (ivy-mode 1)
;;   ;; make swiper to use helm display
;;   (setq swiper-helm-display-function 'helm-default-display-buffer)
;;   (setq ivy-use-virtual-buffers t)
;;   (global-set-key "\C-s" 'swiper-helm)
;;   (global-set-key "\C-r" 'swiper-helm)
;;   (global-set-key (kbd "C-c C-r") 'ivy-resume)
;;   (global-set-key [f8] 'ivy-resume))


;; (use-package aggressive-indent
;;   :config
;;   (global-aggressive-indent-mode 1))


(use-package google-translate
  :config
  (setq  google-translate-default-source-language "en")
  (setq  google-translate-default-target-language "kn")
  (require 'google-translate-default-ui))


(use-package ace-link
  :config
  (ace-link-setup-default "f"))


(use-package sotlisp)


(use-package benchmark-init
  :config
  (benchmark-init/activate))


;; sql config
(require 'sql)
(use-package sqlup-mode
  :config
  (add-hook 'sql-mode-hook 'sqlup-mode))

(use-package sql-indent
  :config
  (eval-after-load "sql"
    '(load-library "sql-indent")))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(sql-set-product "mysql")
(setq sql-port 3306)
(setq sql-connection-alist
      '(
        (mysql-server
         (sql-server sql-server-address)
         (sql-user sql-server-user)
         (sql-password sql-server-password)
         (sql-database sql-server-database)
         (sql-port sql-port))
        (mysql-local
         (sql-server sql-local-server)
         (sql-user sql-local-user)
         (sql-password sql-local-password)
         (sql-database sql-local-database)
         (sql-port sql-port))
        (psql-local
         (sql-server psql-local-server)
         (sql-user psql-local-user)
         (sql-password psql-local-password)
         (sql-database psql-local-database)
         (sql-port psql-port))
        ))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
           (flet ((sql-get-login (&rest what)))
             (sql-product-interactive sql-product)))))

(defun sql-mysql-server ()
  (interactive)
  (sql-connect-preset 'pool-server))

(defun sql-mysql-local ()
  (interactive)
  (sql-connect-preset 'pool-local))

(defun mysql-get-or-create-process ()
  "Get or create an inferior Python process for current buffer and return it."
  (sql-connect))

(defun mysql-send-paragraph ()
  (interactive)
  (sql-connect)
  (sql-send-paragraph)
  (with-current-buffer (process-buffer (get-process "SQL"))
    (set-window-point (get-buffer-window (current-buffer))
                      (point-max))))

(defun sql-add-newline-first (output)
  "Add newline to beginning of OUTPUT for `comint-preoutput-filter-functions'"
  (remove-hook 'comint-preoutput-filter-functions
               'sql-add-newline-first)
  (concat "\n" output))

;; (defun my-sql-save-history-hook ()
;;   (let ((lval 'sql-input-ring-file-name)
;;         (rval 'sql-product))
;;     (if (symbol-value rval)
;;         (let ((filename
;;                (concat "~/.emacs.d/sql/"
;;                        (symbol-name (symbol-value rval))
;;                        "-history.sql")))
;;           (set (make-local-variable lval) filename))
;;       (error
;;        (format "SQL history will not be saved because %s is nil"
;;                (symbol-name rval))))))

;; (add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

;; (defun sql-add-newline-first (output)
;;   "Add newline to beginning of OUTPUT for `comint-preoutput-filter-functions'"
;;   (concat "\n" output))

;; (defun sqli-add-hooks ()
;;   "Add hooks to `sql-interactive-mode-hook'."
;;   (add-hook 'comint-preoutput-filter-functions
;;             'sql-add-newline-first))

;; (add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)


;; slides
;; (load-file "~/.emacs.d/vendor/htmlize.el")
(use-package htmlize)


(use-package org
  :config
  (setq org-agenda-span 30)
  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
  (define-key org-mode-map (kbd "C-c C-c") #'org-reveal-export-to-html-and-browse))


(use-package ox-reveal
  :config
  (setq org-reveal-root "file:///home/anand/.emacs.d/vendor/reveal.js"))

(use-package ob-translate)


(use-package restclient)


(use-package coffee-mode)


;; (use-package wakatime-mode
;;   :config
;;   (setq wakatime-python-bin "/usr/bin/python")
;;   (setq wakatime-python-bin "/usr/local/bin/wakatime")
;;   (global-wakatime-mode))



(use-package ace-window
  :config
  (global-set-key (kbd "M-p") 'ace-window)
  (setq aw-keys '(?d ?f ?g ?h ?j ?k)))


;; (use-package neotree
;;   :config
;;   (global-set-key [f8] 'neotree-toggle))

(use-package dired-subtree
  :config
  (define-key dired-mode-map "i" 'dired-subtree-insert)
  (define-key dired-mode-map ";" 'dired-subtree-remove))


(use-package direx
  :config
  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory))


;; (use-package dirtree
;;   :config
;;   (use-package tree-mode)
;;   (use-package windata)

;;   (defun neotree-current ()
;;     (interactive)
;;     (neotree-dir default-directory))

;;   (global-set-key [f8] #'neotree-current))

(use-package focus)

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))


(use-package vimish-fold
  :config
  (vimish-fold-global-mode-enable-in-buffers)
  (add-hook 'markdown-mode-hook #'vimish-fold-mode))



(use-package ivy-dired-history
  :config
  (with-eval-after-load 'dired
    (define-key dired-mode-map "," 'dired))
  (add-to-list 'savehist-additional-variables 'ivy-dired-history-variable))


(use-package electric-operator
  :config
  (add-hook 'python-mode-hook #'electric-operator-mode))


(use-package company-quickhelp
  :config
  (company-quickhelp-mode 1))

(use-package dimmer
  :config
  (setq dimmer-fraction 0.5)
  (dimmer-mode))



;; (use-package ctags-update)




(use-package pointback)

(use-package diff-hl
  :config
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode)
  (diff-hl-dired-mode))


;; (use-package sx
;;   :config
;;   (require 'sx-load))


(use-package edit-server
  :init
  (when (require 'edit-server nil t)
    (setq edit-server-new-frame nil)
    (edit-server-start)))


(use-package free-keys)



(use-package impatient-mode)


(use-package highlight-symbol
  :init
  (progn
    (global-set-key [f3] 'highlight-symbol-next)
    (global-set-key [(shift f3)] 'highlight-symbol-prev)
    (global-set-key [(control f3)] 'highlight-symbol)
    (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
    (highlight-symbol-mode 1)
    (highlight-symbol-nav-mode 1)))

(use-package markdown-mode
  :config
  (add-hook 'markdown-mode-hook 'writeroom-mode)
  (add-hook 'markdown-mode-hook 'writegood-mode)
  (add-hook 'markdown-mode-hook 'artbollocks-mode))



(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))


(use-package bm
  :config
  (global-set-key (kbd "<f5>") 'bm-toggle)
  (global-set-key (kbd "<f7>") 'bm-next)
  (global-set-key (kbd "<f6>") 'bm-previous))


(use-package flycheck-pos-tip
  :config
  (eval-after-load 'flycheck
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

(defun git-sync ()
  (interactive)
  (message "Syncing repo...")
  (async-shell-command "git pull && git push")
  (magit-refresh))


(use-package engine-mode
  :config
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d"))
