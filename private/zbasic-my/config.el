
(spacemacs|define-jump-handlers kotlin-mode)
(add-hook 'kotlin-mode-hook '(lambda () (lsp nil)))
(add-hook 'kotlin-mode-hook 'periodic-refresh-lsp-kotlin)
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?$ ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?< ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?> ".")))

(setq evil-escape-key-sequence "z[")
