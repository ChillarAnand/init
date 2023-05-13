;;; init.el --- Emacs Config
;;

;;; Code:

(require 'cl)
(require 'package)


;; set better defaults
(load-file "~/.emacs.d/defaults.el")


;; deprecated
;; (load-file "~/.emacs.d/deprecated.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Third party packages

;; add melpa to archives
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-refresh-contents)
(package-initialize)

;; dont check signatures
(setq package-check-signature nil)


;; install use package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)



;; general packages


;; dired config
(require 'dired)
;; (use-package dired+)
;; (use-package dired-details+)

(setq dired-recursive-deletes 'always
      dired-recursive-copies 'always
      delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs"
      dired-no-confirm t
      dired-dwim-target t
      dired-deletion-confirmer '(lambda (x) t)
      dired-details-hide-link-targets nil)

(setq-default dired-omit-mode t)
(setq-default dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\.")

;; auto revert dired buffers
(add-hook 'dired-mode-hook 'auto-revert-mode)
(define-key dired-mode-map "u" 'dired-up-directory)
(define-key dired-mode-map (kbd "C-o") 'dired-omit-mode)

;; (diredp-toggle-find-file-reuse-dir 1)

;; unzip zipped file dired
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

;;(add-to-list 'dired-omit-extension ".example")
;;(add-to-list 'dired-omit-extension ".pyc")



;; navigation

(use-package goto-last-change
  :config
  (global-set-key (kbd "M-m") 'goto-last-change)
  (global-set-key (kbd "M-[") 'goto-last-change)
  )


(use-package saveplace
  :init
  (save-place-mode))


(use-package windmove
  :config
  (windmove-default-keybindings))


;; programming mode packages


(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t)
  (setq projectile-cache-file (expand-file-name  ".projectile.cache" root-dir))
  ;; (projectile-ignore-global ".DS_Store" ".gitmodules" ".gitignore")
  ;; (setq projectile-ignored-files (append projectile-ignored-files '("node_modules" "bower_components")))
  ;; (setq projectile-indexing-method 'native)
  )

(use-package all-the-icons
  :if (display-graphic-p))



(use-package all-the-icons-dired-mode)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)


(use-package dired
  ..other setup stuff here..
  :config
  (use-package all-the-icons-dired
    :if (display-graphic-p)
    :hook (dired-mode . all-the-icons-dired-mode)
    :config (setq all-the-icons-dired-monochrome nil)))

(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))


;; (use-package real-auto-save
;;   :config
;;   (add-hook 'prog-mode-hook 'real-auto-save-mode)
;;   (setq real-auto-save-interval 10))



(use-package yasnippet
  :config
  (yas-global-mode 1))


;; (use-package auctex
;;   :ensure t
;; )

(defun reload-pdf ()
  (interactive
  (let* ((fname buffer-file-name)
        (fname-no-ext (substring fname 0 -4))
        (pdf-file (concat fname-no-ext ".pdf"))
        (cmd (format "pdflatex %s" fname)))
    (delete-other-windows)
    (split-window-horizontally)
    (split-window-vertically)
    (shell-command cmd)
    (other-window 2)
    (find-file pdf-file)
    (balance-windows))))

(global-set-key "\C-x\p" 'reload-pdf)


;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))





;; python mode
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-completion-native-enable nil)
(setq python-indent-offset 4)
(setq python-indent-guess-indent-offset nil)

(use-package pyvenv)
(use-package highlight-indentation)
(use-package company
  :config
  (global-company-mode 1)

  (setq company-idle-delay 0)
  (setq company-tooltip-limit 5)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-flip-when-above t)

  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(use-package elpy)
(add-to-list 'load-path "~/projects/elpy")
(load "elpy" nil t)
(elpy-enable)

(setq elpy-test-runner 'elpy-test-pytest-runner)
(setq elpy-rpc-timeout nil)
(setq elpy-rgrep-file-pattern "*.py *.html")
(setq elpy-rpc-backend "jedi")
(setq elpy-rpc-virtualenv-path `current)
;; (setq elpy-rpc-python-command "python3")
(pyvenv-workon "py35")
(elpy-rpc-restart)

(add-to-list 'grep-find-ignored-files "flycheck_*")
(add-to-list 'grep-find-ignored-directories "htmlcov")


(defun elpy-goto-definition-or-template ()
  (interactive)
  (if (inside-string)
      (elpy-goto-template)
    (elpy-goto-definition)))

(defun elpy-goto-template ()
  (interactive)
  (let ((file-name (thing-at-point 'filename)))
    (find-file (expand-file-name
                (dolist (f (projectile-current-project-files))
                  (if (s-contains? file-name f)
                      (return f)))
                (projectile-project-root)))))


(defun my/send-region-or-buffer (&optional arg)
  (interactive "P")
  (elpy-shell-send-region-or-buffer arg)
  (with-current-buffer (process-buffer (elpy-shell-get-or-create-process))
    (set-window-point (get-buffer-window (current-buffer))
                      (point-max))))

(define-key elpy-mode-map (kbd "C-c C-c") 'my/send-region-or-buffer)
(define-key elpy-mode-map (kbd "<return>") 'elpy-open-and-indent-line-below)
(define-key elpy-mode-map (kbd "M-,") 'pop-tag-mark)

(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))

(add-hook 'company-mode-hook
          (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
             company-active-map)))


;; (use-package pony-mode)

(use-package wrap-region)


(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-c m e") 'mc/edit-lines)
  (global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this))


;; (use-package header2)


(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tmpl?\\'" . web-mode))
  (setq web-mode-engines-alist '(("django" . "\\.html\\'")))

  (setq-default indent-tabs-mode nil)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-js-indent-offset 4)
  (setq web-mode-enable-current-element-highlight t)

  (setq web-mode-script-padding 0)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-auto-pairing nil)

  (set (make-local-variable 'company-backends) '(company-css))

  (bind-key "C-c C-i" 'web-mode-buffer-indent)
  (bind-key "C-c C-l" 'web-mode-fold-or-unfold))


(use-package nyan-mode
  :config
  (nyan-mode))


(use-package magit
  :config

  (defun my-magit-status ()
    "Don't split window."
    (interactive)
    (let ((pop-up-windows nil))
      (call-interactively 'magit-status)
      (magit-section-forward-sibling)
      (magit-section-forward)))

  (defun auto-display-magit-process-buffer (&rest args)
    "Automatically display the process buffer when it is updated."
    (let ((magit-display-buffer-noselect t))
      (magit-process-buffer)))

  (defun auto-hide-magit-process-buffer (&rest args)
    "Automatically display the process buffer when it is updated."
    (let ((magit-display-buffer-noselect nil))
      (magit-process-buffer)))

  (advice-add 'magit-process-insert-section :before
              #'auto-display-magit-process-buffer)

  ;; (advice-add 'magit-process-insert-section :after
  ;;             #'auto-hide-magit-process-buffer)

  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-last-seen-setup-instructions "1.4.0")
  (global-git-commit-mode)

  (define-key magit-mode-map (kbd "M-p") nil)
  (define-key magit-mode-map (kbd "p") 'magit-push)
  (define-key magit-mode-map (kbd "f") 'magit-pull)
  (define-key magit-mode-map (kbd "F") 'magit-fetch)
  (define-key magit-mode-map (kbd "C-c C-s") 'git-sync)
  )


;; (use-package git-gutter
;;   :config
;;   (global-git-gutter-mode +1)
;;   )

(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )


;; theme

(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  (setq rm-whitelist "elpy")
  (sml/setup)
  (sml/apply-theme 'light))

(use-package comment-dwim-2
  :init
  (global-set-key (kbd "M-;") 'comment-dwim-2))


(use-package easy-kill
  :config
  (bind-key "M-w" 'easy-kill))


(use-package paren
  :config
  (setq show-paren-style 'parenthesis)
  (show-paren-mode +1))

(use-package helm-chrome)
(use-package helm-descbinds)
(use-package helm-projectile)
(use-package helm-ag)
(use-package helm-dired-recent-dirs)
(use-package helm-github-stars
  :config
  (setq helm-github-stars-username "chillaranand"))

(use-package helm-swoop
  :config
  (setq helm-swoop-speed-or-color t)
  (setq helm-swoop-split-with-multiple-windows t)
  (global-set-key "\C-s" 'helm-swoop-without-pre-input))


(use-package helm
  :config

  (require 'helm-eshell)

  (defvar helm-source-emacs-commands
    (helm-build-sync-source "Emacs commands"
      :candidates (lambda ()
                    (let ((cmds))
                      (mapatoms
                       (lambda (elt) (when (commandp elt) (push elt cmds))))
                      cmds))
      :coerce #'intern-soft
      :action #'command-execute)
    "A simple helm source for Emacs commands.")

  (defvar helm-source-emacs-commands-history
    (helm-build-sync-source "Emacs commands history"
      :candidates (lambda ()
                    (let ((cmds))
                      (dolist (elem extended-command-history)
                        (push (intern elem) cmds))
                      cmds))
      :coerce #'intern-soft
      :action #'command-execute)
    "Emacs commands history")

  (setq helm-mini-default-sources '(helm-source-buffers-list
                                    helm-source-recentf
                                    ;; helm-source-dired-recent-dirs
                                    ;; helm-source-emacs-commands-history
                                    ;; helm-source-emacs-commands
                                    ;; helm-chrome-source
                                    ;; hgs/helm-c-source-stars
                                    ;; hgs/helm-c-source-repos
                                    ;; helm-source-buffer-not-found
                                    ;; hgs/helm-c-source-search
                                    ))

  (setq  helm-ff-newfile-prompt-p              nil
         helm-echo-input-in-header-line        t
         helm-M-x-always-save-history          t
         helm-split-window-in-side-p           t
         helm-buffers-fuzzy-matching           t
         helm-move-to-line-cycle-in-source     t
         helm-ff-search-library-in-sexp        t
         helm-ff-file-name-history-use-recentf t)

  (bind-key "C-c C-o" 'helm-buffer-switch-other-window))


(use-package helm-flx
  :config
  (helm-flx-mode +1)
  (setq helm-flx-for-helm-find-files t ;; t by default
        helm-flx-for-helm-locate t))
;; writing

(use-package writegood-mode)
(use-package writeroom-mode)
(use-package artbollocks-mode)


(use-package key-chord
  :config
  ;; (setq key-chord-one-keys-delay 0.5)
  ;; (setq key-chord-two-keys-delay 0.5)
  )


(use-package which-key
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))


(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))


(use-package hl-line
  :config
  (global-hl-line-mode 1))


(use-package lispy
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))

  (define-key lispy-mode-map (kbd "C-;") #'comment-or-uncomment-sexp)
  (define-key lispy-mode-map (kbd "M-m") nil)
  ;; (define-key lispy-mode-map (kbd "C-k") #'my-lispy-kill)
  (define-key lispy-mode-map (kbd "C-c C-v") #'eval-buffer))


(use-package paradox)
;; (use-package sqlplus)


;; load utils
(load-file "~/.emacs.d/utils.el")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; key bindings


(bind-keys*
 ("<f12>" . menu-bar-mode)

 ("C-+" . text-scale-increase)
 ("C-," .  avy-goto-char)
 ("C-^" .  top-join-line)
 ("C-1" . just-one-space)

 ("C-x C-1" . delete-other-windows)
 ("C-x C-3" . split-window-right)
 ("C-x C-a" . beginning-of-buffer)
 ("C-x C-b" . switch-to-previous-buffer)
 ("C-x C-d" . duplicate-current-line-or-region)
 ;; ("C-x C-h" . mark-whole-buffer)
 ("C-x C-g" . space-to-ctrl-activate)


 ("C-c C-k" . delete-other-windows)
 ("C-x C-i" . delete-other-windows)
 ("C-x C-k" . kill-this-buffer)
 ("C-x C-m" . helm-M-x)
 ("C-x C-o" . dired-remote)
 ("C-x C-z" . end-of-buffer)
 ("C-x r l" . helm-bookmarks)

 ("C-x C-f" . helm-find-files)
 ("C-c C-g" . beginning-of-buffer)

 ("M-o" . other-window)
 ("M-x" . helm-M-x)
 ("M-y" . helm-show-kill-ring)
 ("M-z" . zop-up-to-char)
 ("M-Z" . zop-to-char)
 ("M-?" . mark-paragraph)
 ("M-/" . hippie-expand)
 )



;; kill lines backward
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

(global-set-key [remap kill-whole-line] 'delete-whole-line)


;;(global-set-key (kbd "C-h") 'delete-backward-char)
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)

;; shell history.
(define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)

;; use helm to list eshell history
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (substitute-key-definition 'eshell-list-history 'helm-eshell-history eshell-mode-map)))

(substitute-key-definition 'find-tag 'helm-etags-select global-map)
(setq projectile-completion-system 'helm)
(helm-descbinds-mode)
(helm-mode 1)



(use-package engine-mode
  :config
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d"))





;; enable Helm version of Projectile with replacment commands
(helm-projectile-on)

;; better defaults for comint mode
(eval-after-load 'comint
  '(progn
     (define-key comint-mode-map (kbd "<up>") #'comint-previous-matching-input-from-input)
     (define-key comint-mode-map (kbd "<down>") #'comint-next-matching-input-from-input)))


(require 'key-chord)
(key-chord-mode +1)
;; (key-chord-define-global "dd" 'delete-whole-line)
(key-chord-define-global "df" 'describe-function)
(key-chord-define-global "dk" 'describe-key)
(key-chord-define-global "dv" 'describe-variable)
(key-chord-define-global "hr" 'helm-resume)
(key-chord-define-global "fj" 'helm-mini)
(key-chord-define-global "jb" 'switch-to-previous-buffer)
(key-chord-define-global "jc" 'avy-goto-char)
(key-chord-define-global "jd" 'helm-dired-recent-dirs-view)
(key-chord-define-global "jl" 'avy-goto-line)
(key-chord-define-global "js" 'helm-semantic-or-imenu)
(key-chord-define-global "kf" 'bury-buffer)
(key-chord-define-global "kw" 'delete-window)
(key-chord-define-global "md" 'current-dired)
(key-chord-define-global "mg" 'my-magit-status)
(key-chord-define-global "mx" 'helm-M-x)
(key-chord-define-global "ps" 'helm-projectile-switch-project)
(key-chord-define-global "pf" 'helm-projectile-find-file)
(key-chord-define-global "pg" 'helm-projectile-grep)
(key-chord-define-global "sm" 'set-mark-command)


;; mac swap command and alt
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hooks


(add-hook 'before-save-hook 'whitespace-cleanup)

(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)

;; load do.org
;; (find-file "~/Dropbox/do.org")

(message "Successfully loaded config... ")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lua-mode all-the-icons-dired-mode all-the-icons-dired all-the-icons dired-sidebar auctex-latexmk auctex acutex engine-mode paradox lispy expand-region which-key key-chord artbollocks-mode writeroom-mode writegood-mode helm-flx helm-swoop helm-github-stars helm-dired-recent-dirs helm-ag helm-projectile helm-descbinds helm-chrome easy-kill comment-dwim-2 smart-mode-line diff-hl magit nyan-mode web-mode multiple-cursors wrap-region elpy company highlight-indentation pyvenv yasnippet use-package projectile goto-last-change)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
