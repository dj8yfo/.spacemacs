
(spacemacs|define-jump-handlers kotlin-mode)
(add-hook 'kotlin-mode-hook '(lambda () (lsp nil)))
(add-hook 'kotlin-mode-hook 'ggtags-mode)
;; (add-hook 'kotlin-mode-hook 'periodic-refresh-lsp-kotlin)
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?$ ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?< ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?> ".")))

(setq evil-escape-key-sequence "z[")


(advice-add 'server-create-window-system-frame :after '(lambda (&rest args)
                                                         (interactive)
							(set-face-font 'default "-xos4-Terminess Powerline-normal-normal-normal-*-14-*-*-*-c-60-iso10646-1" )))
;(advice-add 'server-create-tty-frame :after ''(lambda (&rest args)
;                                                         (interactive)
;                                                        (set-face-font 'default "-xos4-Terminess Powerline-normal-normal-normal-*-14-*-*-*-c-60-iso10646-1" )))
