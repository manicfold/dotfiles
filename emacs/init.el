;; paths and directories -------------------------------------------------------
;; Don't litter script with Custom settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; add "lisp" subdirectory to path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; store backup files in a central directory
(setq backup_directory (expand-file-name "saves" user-emacs-directory))
(unless (file-directory-p backup_directory) (mkdir backup_directory))
(setq backup-directory-alist `(("." . backup_directory)))

;; Package setup ---------------------------------------------------------------
(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; packages --------------------------------------------------------------------
(use-package magit
  :ensure t)

(use-package helm
  :ensure t)

(use-package org
  :ensure t)

(require 'init-evil)
(require 'init-theme)
(require 'init-completion)

;; setup powerline
; (add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
; (require 'powerline)
(use-package powerline
  :ensure t)
(use-package powerline-evil
  :ensure t)

(use-package fill-column-indicator
  :ensure t
  :config
  (setq fci-rule-column 80)
  (setq fci-rule-width 1)
  (setq fci-rule-color "dim gray")
  (fci-mode)
  )

(show-paren-mode 1)
