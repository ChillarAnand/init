;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; basic config

;; load custom variables
(load "~/.emacs.d/custom.el")
;;(load-file "~/Dropbox/tech/private.el")


;; dont truncate log messages
(setq message-log-max t)

;; set package-user-dir to be relative to ~/.emacs.d/
(defvar root-dir (file-name-directory load-file-name)
  "The root dir of the Emacs")
(setq package-user-dir (expand-file-name "elpa" root-dir))
(setq package-vendor-dir (expand-file-name "vendor" root-dir))
(setq recent-files-dir (expand-file-name "recentf" root-dir))


;; turno off sounds
(setq visible-bell 1)
;; (setq ring-bell-function 'ignore)


;; Always load newest byte code
;; (setq load-prefer-newer t)

;; turn on debug
;; (toggle-debug-on-error)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; dont prompt while creating new buffer
(setq confirm-nonexistent-file-or-buffer nil)

;; kill process buffer without confirmation
(setq kill-buffer-query-functions
      (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; confirm before killing emacs
;; (setq confirm-kill-emacs
;;       (lambda (&rest _)
;;         (message "Quit in 3 sec (`C-g' or other action cancels)")
;;         (sit-for 3)))


;; always split vertically
;; (setq split-height-threshold nil)
;; (setq split-width-threshold 0)


;; always kill line with whitespace
;; (setq kill-whole-line t)

(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 32000)

;; enable auto copy
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
;; (setq mouse-drag-copy-region t)



;; (setq temporary-file-directory "/tmp")
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ui config

;; maximize on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(toggle-frame-fullscreen)
(set-frame-parameter nil 'fullscreen 'fullboth)


;; disable tool bar
(tool-bar-mode -1)

;; disable menu bar
(menu-bar-mode -1)

;; disable blinking
(blink-cursor-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; set fond & colors
;; (set-default-font "Ubuntu Mono 13")
(set-background-color "#f1f1f1")
(add-to-list 'default-frame-alist '(background-color . "#f1f1f1"))

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)

;; show size in mode line
;; (size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; set frame title
(setq frame-title-format
      '("" invocation-name
        " Avil Page - "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages


;; save recent files
(require 'recentf)
(setq
 ;; recentf-save-file (expand-file-name "recentf" recent-files-dir)
 recentf-max-saved-items 500
 recentf-max-menu-items 15
 ;; disable recentf-cleanup on Emacs start, because it can cause
 ;; problems with remote files
 recentf-auto-cleanup 'never)
(recentf-mode +1)
(run-at-time nil (* 5 60) 'recentf-save-list)
(run-with-idle-timer 5  nil 'recentf-cleanup)


;; save history
(savehist-mode 1)
(setq history-length 1000)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
;; (setq savehist-file "~/.emacs.d/savehist")


;; enable semantic mode
(semantic-mode 1)
