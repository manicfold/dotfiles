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

(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

(provide 'init-completion)
