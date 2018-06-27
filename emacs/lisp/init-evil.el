;; setup VI layer
(defun air--config-evil-leader ()
  "Configure evil leader mode."
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ":"  'eval-expression
    "b"  'helm-mini             ;; Switch to another buffer
    "B"  'magit-blame-toggle
    "f"  'helm-imenu            ;; Jump to function in buffer
    "g"  'magit-status
    "l"  'whitespace-mode       ;; Show invisible characters
    "p"  'helm-show-kill-ring
    "q"  'kill-this-buffer
    "S"  'delete-trailing-whitespace
    ;; "t"  'gtags-reindex
    ;; "T"  'gtags-find-tag
    "w"  'save-buffer
    "x"  'helm-M-x
    )

  (defun magit-blame-toggle ()
    "Toggle magit-blame-mode on and off interactively."
    (interactive)
    (if (and (boundp 'magit-blame-mode) magit-blame-mode)
	(magit-blame-quit)
      (call-interactively 'magit-blame))))


(defun air--config-evil ()
  "Configure evil mode."

  ;; Use Emacs state in these additional modes.
  (dolist (mode '(custom-mode
		  custom-new-theme-mode
		  dired-mode
		  eshell-mode
		  git-rebase-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode))

  (delete 'term-mode evil-insert-state-modes)
  (delete 'eshell-mode evil-insert-state-modes)

  ;; Use insert state in these additional modes.
  (dolist (mode '(magit-log-edit-mode))
    (add-to-list 'evil-insert-state-modes mode))

  (evil-add-hjkl-bindings occur-mode-map 'emacs
    (kbd "/")       'evil-search-forward
    (kbd "n")       'evil-search-next
    (kbd "N")       'evil-search-previous
    (kbd "C-d")     'evil-scroll-down
    (kbd "C-u")     'evil-scroll-up
    (kbd "C-w C-w") 'other-window)

  ;; Global bindings.
  (evil-define-key 'normal global-map (kbd "-")       'helm-find-files)
  ;; (evil-define-key 'normal global-map (kbd "C-]")     'gtags-find-tag-from-here)
  (evil-define-key 'normal global-map (kbd "C-p")     'helm-projectile)
  ;; (evil-define-key 'normal global-map (kbd "C-S-p")   'helm-projectile-switch-project)
  (evil-define-key 'normal global-map (kbd "C-h")     'windmove-left)
  (evil-define-key 'normal global-map (kbd "C-j")     'windmove-down)
  (evil-define-key 'normal global-map (kbd "C-k")     'windmove-up)
  (evil-define-key 'normal global-map (kbd "C-l")     'windmove-right)

  (defun minibuffer-keyboard-quit ()
    "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (interactive)
    (if (and delete-selection-mode transient-mark-mode mark-active)
	(setq deactivate-mark  t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
      (abort-recursive-edit)))

  ;; Make escape quit everything, whenever possible.
  ;; (define-key evil-normal-state-map [escape] 'keyboard-escape-quit)
  ;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  )

(use-package evil
  :ensure t
  :config
  (add-hook 'evil-mode-hook 'air--config-evil)
  (evil-mode t))

(use-package evil-leader
  :ensure t
  :requires evil
  :config
  (global-evil-leader-mode)
  (air--config-evil-leader)
  )

(use-package evil-org
  :ensure t
  :requires (evil org)
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  ;;(add-hook 'evil-org-mode-hook
  ;;	      (lambda ()
  ;;		(evil-org-set-key-theme '(navigation insert textobjects additional)))
  ;;(require 'evil-org-agenda)
  ;;(evil-org-agenda-set-keys)
  )

(use-package evil-surround
  :ensure t
  :requires evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :requires evil
  :config
  (evil-commentary-mode))

;; (use-package evil-repeat
;;   :ensure t
;;   :requires evil)

(use-package evil-visual-mark-mode
  :ensure t
  :requires evil
  :config (evil-visual-mark-mode 1))

(use-package evil-magit
  :ensure t
  :requires (evil magit))

(require 'evil-magit)
  
(provide 'init-evil)

