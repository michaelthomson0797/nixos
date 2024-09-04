(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Turn off unwanted GUI elements.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

;; Set the default font.
;; Append a size -NN to the font name.
(add-to-list 'default-frame-alist
             '(font . "Iosevka Nerd Font-16"))

;; garbage collect when not in focus
(if (boundp 'after-focus-change-function)
    (add-function :after after-focus-change-function
                  (lambda () (unless (frame-focus-state)
                               (garbage-collect))))
  (add-hook 'after-focus-change-function
            'garbage-collect))

;; set name and email
(setq user-full-name "Michael Thomson")
(setq user-mail-address "michael@michaelthomson.dev")

;; display columna nd line numbers on all buffers
(column-number-mode 1)
(global-display-line-numbers-mode 1)

;; paren closing and tab fix
(electric-pair-mode 1)
(electric-indent-mode -1)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default indent-line-function 'insert-tab)

;; save history of mini buffer commands and opened files
(savehist-mode 1)
(recentf-mode 1)

;; disable lock file creation and send backups to a different directory
(setq backup-directory-alist '(("." . "~/.saves")))
(setq backup-by-copying t)
(setq version-control t)
(setq delete-old-versions t)
(setq create-lockfiles nil)

;; scroll wheel improvments
(setq mouse-wheel-progressive-speed nil)
(setq scroll-conservatively 101)

;; y or n for prompts
(setq use-short-answers t)
(setq use-dialog-box nil)

;; disable startup screen and messages buffer
(setq inhibit-startup-message t)
(setq message-log-max nil)
(kill-buffer "*Messages*")

;; prog mode truncate lines and highlight lines
(add-hook 'prog-mode-hook
          (lambda () (toggle-truncate-lines 1)))
(add-hook 'prog-mode-hook 'hl-line-mode)

;; theme
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'frappe) ;; or 'latte, 'macchiato, or 'mocha
  (catppuccin-reload))


;; evil
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (setq evil-want-keybinding nil
        evil-auto-indent nil
        evil-want-C-u-scroll t
        evil-shift-width 2
        evil-undo-system 'undo-redo
        evil-vsplit-window-right t)
  (evil-mode t))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; vertico
(use-package vertico
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

;; icons
(use-package all-the-icons
  :if (display-graphic-p))

;;;; Code Completion
(use-package corfu
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-auto-delay 0) ;; TOO SMALL - NOT RECOMMENDED
  (corfu-auto-prefix 1)
  :init
  (global-corfu-mode))

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))


;; treesitter
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-use-plists t)
  :hook ((tsx-ts-mode . lsp)
         (typescript-ts-mode . lsp)
         (js-ts-mode . lsp)
         (go-ts-mode . lsp)
         (vue-mode . lsp))
  :commands lsp)


(use-package lsp-ui :commands lsp-ui-mode)

(setq read-process-output-max (* 10 1024 1024)) ;; 10mb
(setq gc-cons-threshold 200000000)

;; emacs-lsp-booster
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

;; languages
(use-package vue-mode)
