
(spacemacs/set-leader-keys "y]" 'clone-kotlin-skeleton)
(with-eval-after-load 'dired (define-key dired-mode-map (kbd "\C-c k") 'clone-kotlin-skeleton))
(spacemacs/set-leader-keys "yf" 'query-kotlin-stdlib)

(with-eval-after-load 'kotlin-mode
  (define-key kotlin-mode-map (kbd "C-c y") 'hydra-android-sources/body))
(with-eval-after-load 'java-mode
  (define-key java-mode-map (kbd "C-c y") 'hydra-android-sources/body))
