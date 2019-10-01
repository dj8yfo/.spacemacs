(defvar sources-browse-jump-back nil)
(defconst kotlin-stdlib-root "/home/hypen9/Documents/code/kotlin/kotlin-stdlib-sources/")
(defconst android-src-root "/home/hypen9/Documents/code/ANDROID_SRC/")
(defvar indexed-sources-subdir nil)

(spacemacs|define-jump-handlers kotlin-mode)
;; (add-hook 'kotlin-mode-hook 'eglot-ensure)
;; (add-hook 'kotlin-mode-hook 'lsp)
(add-hook 'kotlin-mode-hook 'ggtags-mode)

                                        ;
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?$ ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?< ".")))
(add-hook 'kotlin-mode-hook '(lambda ()
                               (modify-syntax-entry ?> ".")))

;; (setq eglot-workspace-configuration '((kotlin . ((compiler . ((jvm . ((target . "1.8")))))))))
