(spacemacs|define-jump-handlers kotlin-mode)
;; (add-hook 'kotlin-mode-hook 'eglot-ensure)
(add-hook 'kotlin-mode-hook 'ggtags-mode)

                                        ;
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?$ ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?< ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?> ".")))

(setq evil-escape-key-sequence "z[")
(setq purpose-layout-dirs '("/home/sysmanj/Documents/.spacemacs/private/zbasic-my/layouts/"))
;; (custom-layout2)
(advice-add 'server-create-window-system-frame
            :after '(lambda
                      (&rest
                       args)
                      (interactive)
                      (set-face-font 'default
                                     "-xos4-Terminess Powerline-normal-normal-normal-*-14-*-*-*-c-80-iso10646-1" )))

(with-eval-after-load 'window-purpose (add-to-list 'purpose-user-mode-purposes '(eshell-mode .
                                                                                             terminal))
                      (add-to-list 'purpose-user-mode-purposes '(compilation-mode . terminal))
                      (add-to-list 'purpose-user-mode-purposes '(org-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(help-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(kotlin-mode . edit))
                      (add-to-list 'purpose-user-mode-purposes '(dired-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(flymake-diagnostics-buffer-mode .
                                                                                                 edit1))
                      (add-to-list 'purpose-user-mode-purposes '(magit-mode . terminal))
                      (purpose-compile-user-configuration))


(if (display-graphic-p) nil
  (setq    dotspacemacs-mode-line-theme '(vim-powerline :separator slant
                                                        :separator-scale 1.1)))
(with-eval-after-load 'magit
		      (global-diff-hl-mode 1))

(with-eval-after-load 'volatile-highlights (volatile-highlights-mode -1))








