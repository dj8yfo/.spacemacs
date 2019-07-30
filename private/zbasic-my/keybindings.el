(evil-global-set-key 'normal (kbd "\C-cl") 'org-store-link)
(evil-global-set-key 'normal (kbd "n") 'evil-next-respect-isearch)
(evil-global-set-key 'normal (kbd "N") 'evil-previous-respect-isearch)
(evil-global-set-key 'normal (kbd ">") 'goto-delimiter-forward)
(evil-global-set-key 'visual (kbd ">") 'goto-delimiter-forward)
(evil-global-set-key 'operator (kbd ">") 'goto-delimiter-forward)
(evil-global-set-key 'normal (kbd "H") 'goto-delimiter-backward-stop)
(evil-global-set-key 'visual (kbd "H") 'goto-delimiter-backward-stop)
(evil-global-set-key 'operator (kbd "H") 'goto-delimiter-backward-stop)
(evil-global-set-key 'normal (kbd "<") 'goto-delimiter-backward)
(evil-global-set-key 'visual (kbd "<") 'goto-delimiter-backward)
(evil-global-set-key 'operator (kbd "<") 'goto-delimiter-backward)
(evil-global-set-key 'visual (kbd "{")
                     '(lambda nil
                        (interactive)
                        (progn (call-interactively (quote evil-shift-left))
                               (execute-kbd-macro "gv"))))
(evil-global-set-key 'visual (kbd "}")
                     '(lambda nil
                        (interactive)
                        (progn (call-interactively (quote evil-shift-right))
                               (execute-kbd-macro "gv"))))
(evil-define-key 'normal evil-matchit-mode-map "M" 'evilmi-jump-items)
(evil-define-key 'visual evil-matchit-mode-map "M" 'evilmi-jump-items)
(evil-define-key 'operator evil-matchit-mode-map "M" 'evilmi-jump-items)
(evil-define-key 'normal flymake-diagnostics-buffer-mode-map (kbd "RET")
  '(lambda ()
     (interactive)
     (beginning-of-line)
     (forward-char 20)
     (flymake-goto-diagnostic (point))))
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "\C-c k") 'clone-kotlin-skeleton))


(with-eval-after-load 'eglot (spacemacs/set-leader-keys "," 'eglot-help-at-point))
(spacemacs/set-leader-keys "ec" 'eshell-copy-last-command-output
                           "o" 'helm-multi-swoop-org
                           "sgp" 'helm-projectile-rg
                           "r/" 'helm-rg
                           "io" 'org-insert-heading
                           ":" 'eval-expression
                          "zp" 'zeal-at-point
                           "ee" 'switch-to-eshell
                           "ys" 'describe-variable-and-kill-value
                           "." 'ido-switch-buffer
                           "df" 'flymake-goto-purposed-window
                           "y]" 'clone-kotlin-skeleton
                           "ei" 'ido-mode
                           "yf" 'query-kotlin-stdlib)

(spacemacs/set-leader-keys "rg" '(lambda () (interactive)
                                   (global-diff-hl-mode -1)
                                   (global-diff-hl-mode 1)))
(spacemacs/set-leader-keys "ef" '(lambda ()
                                   (interactive)
                                   (elisp-format-file buffer-file-name)
                                   (delete-trailing-whitespace)))
(spacemacs/set-leader-keys "[" '(lambda ()
                                  (interactive)
                                  (evil--jumps-jump 0 0)))


(global-unset-key (kbd "M-l"))
(global-set-key (kbd "M-l a") 'custom-layout1)
(global-set-key (kbd "M-l b") 'custom-layout2)
(global-set-key (kbd "\C-xb") 'ido-switch-buffer)
(global-set-key (kbd "\C-x\C-f") 'ido-find-file)
(global-set-key (kbd "\C-x.") 'helm-eshell-history)
(global-set-key (kbd "\C-x.") 'helm-eshell-history)
(global-set-key (kbd "\C-x/") 'helm-complex-command-history)
(global-set-key (kbd "\C-x,") 'command-history)
(global-set-key (kbd "\C-x]") 'ace-window)
(global-set-key (kbd "\C-xg") 'magit-status)

(global-set-key (kbd "C-M-n") 'evil-jump-forward)
(global-set-key (kbd "C-o") 'evil-jump-backward)

(global-set-key (kbd "M-h") 'backward-delete-char)
(global-set-key (kbd "C-M-]") 'company-complete)
(global-set-key (kbd "M-\\") 'xref-find-definitions)
(global-set-key (kbd "M-[") 'xref-pop-marker-stack)
(global-set-key (kbd "\C-c4") 'xref-find-definitions-other-window)
