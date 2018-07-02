;; paths and directories -------------------------------------------------------
;; Don't litter script with Custom settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; personal information
(setq personal-file (expand-file-name "personal.el" user-emacs-directory))
(load personal-file 'noerror)

;; add "lisp" subdirectory to path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; store backup files in a central directory
(setq backup_directory (expand-file-name "saves" user-emacs-directory))
(unless (file-directory-p backup_directory) (mkdir backup_directory))
(setq backup-directory-alist (list (cons "." backup_directory)))

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
(use-package helm-ag
  :ensure t
  :requires helm)

(use-package org
  :ensure t)

(require 'init-evil)
(require 'init-theme)
(require 'init-completion)

(use-package fill-column-indicator
  :ensure t
  :config
  (setq fci-rule-column 80)
  (setq fci-rule-width 1)
  (setq fci-rule-color "dim gray")
  (fci-mode)
  )

(show-paren-mode 1)
(global-hl-line-mode 1)
(setq-default c-basic-offset 3)

;; open all .h files in C++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; auto-enable hide-show mode for C/C++ files
(add-hook 'c-mode-common-hook #'hs-minor-mode)

;; multi-window / single-window quickswitch
(winner-mode 1)
