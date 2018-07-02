(use-package powerline
  :ensure t)
(setq powerline-default-separator 'slant)
(powerline-default-theme)


(use-package material-theme
  :ensure t)

(setq philipp/themes '(material material-light))
(setq philipp/themes-index 0)

(defun philipp/cycle-theme ()
  (interactive)
  (setq philipp/themes-index (% (1+ philipp/themes-index) (length philipp/themes)))
  (philipp/load-indexed-theme))

(defun philipp/load-indexed-theme ()
  (philipp/try-load-theme (nth philipp/themes-index philipp/themes)))

(defun philipp/try-load-theme (theme)
  (if (ignore-errors (load-theme theme :no-confirm))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))

(philipp/load-indexed-theme)
       
(evil-leader/set-key
  "L"  'philipp/cycle-theme)

(provide 'init-theme)
