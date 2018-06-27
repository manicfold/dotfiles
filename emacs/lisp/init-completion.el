(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package auto-complete
  :ensure t
  :config (ac-config-default))

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'c++-mode-hook #'yas-minor-mode)
  (add-hook 'c-mode-hook #'yas-minor-mode))

(use-package yasnippet-snippets
  :ensure t)

;; (use-package company
;;   :ensure t)

;; (use-package company-irony
;;   :ensure t
;;   :requires (company irony)
;;   :config
;;   (add-to-list 'company-backends 'company-irony))

;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
;; (defvar company-mode/enable-yas t
;;   "Enable yasnippet for all backends.")

;; (defun company-mode/backend-with-yas (backend)
;;   (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
;;       backend
;;     (append (if (consp backend) backend (list backend))
;; 	    '(:with company-yasnippet))))

;; (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; (company-mode 1)

(provide 'init-completion)
