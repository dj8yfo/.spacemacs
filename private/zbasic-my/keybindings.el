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
(with-eval-after-load 'dired (define-key dired-mode-map (kbd "\C-c k") 'clone-kotlin-skeleton))


(with-eval-after-load 'eglot (spacemacs/set-leader-keys "," '(lambda ()
                                                               (interactive)
                                                               (let ((buffer (current-buffer)))
                                                                 (eglot-help-at-point)
                                                                 (switch-to-buffer buffer)))))
(spacemacs/set-leader-keys "ec" 'eshell-copy-last-command-output)
(spacemacs/set-leader-keys "o" 'helm-multi-swoop-org)
(spacemacs/set-leader-keys "ao" 'org-agenda)
(spacemacs/set-leader-keys "sgp" 'helm-projectile-rg)
(spacemacs/set-leader-keys "r/" 'helm-rg)
(spacemacs/set-leader-keys "io" 'org-insert-heading)
(spacemacs/set-leader-keys ":" 'eval-expression)
(spacemacs/set-leader-keys "ds" 'wordnut-search)
(spacemacs/set-leader-keys "dw" 'dictionary-search)
(spacemacs/set-leader-keys "ee" 'switch-to-eshell)
(spacemacs/set-leader-keys "ys" 'describe-variable-and-kill-value)
(spacemacs/set-leader-keys "yc" '(lambda ()
                                   (interactive)
                                   (kill-new (pwd))))
(spacemacs/set-leader-keys "." 'ido-switch-buffer)
(spacemacs/set-leader-keys "dd" 'flymake-goto-purposed-window)
(spacemacs/set-leader-keys "y]" 'clone-kotlin-skeleton)
(spacemacs/set-leader-keys "ei" 'ido-mode)
(spacemacs/set-leader-keys "yf" 'query-kotlin-stdlib)
(spacemacs/set-leader-keys "ss" 'swiper)
(spacemacs/set-leader-keys "pn" 'export-notes-to-html)
(spacemacs/set-leader-keys "rg" '(lambda ()
                                   (interactive)
                                   (global-diff-hl-mode -1)
                                   (global-diff-hl-mode 1)))
(spacemacs/set-leader-keys "ef" '(lambda ()
                                   (interactive)
                                   (elisp-format-file buffer-file-name)
                                   (delete-trailing-whitespace)))
(spacemacs/set-leader-keys "[" '(lambda ()
                                  (interactive)
                                  (evil--jumps-jump 0 0)))
(spacemacs/set-leader-keys "zk" '(lambda ()
                                   (interactive)
                                   (setq zeal-at-point-docset "kotlin")))
(spacemacs/set-leader-keys "za" '(lambda ()
                                   (interactive)
                                   (setq zeal-at-point-docset "android")))
(spacemacs/set-leader-keys "=" 'spacemacs/scale-transparency-transient-state/body)
(spacemacs/set-leader-keys "dl" '(lambda ()
                                   (interactive)
                                   (delete-window (get-buffer-window "*tex-shell*"))))
(spacemacs/set-leader-keys "e/" '(lambda (arg)
                                   (interactive "sSearch for:")
                                   (let ((searchcmd (format
                                                     "https://startpage.com/do/search?language=english&cat=web&query=%s"
                                                     arg)))
                                     (message (format "searching `%s'" searchcmd))
                                     (eww searchcmd))))
(spacemacs/set-leader-keys "e<" 'eww-back-url)
(spacemacs/set-leader-keys "e>" 'eww-forward-url)
(spacemacs/set-leader-keys "s?" '(lambda ()
                                   (interactive)
                                   (let ((browse-url-browser-function 'eww-browse-url))
                                     (call-interactively 'browse-url))))
(spacemacs/set-leader-keys "s/" '(lambda ()
                                   (interactive)
                                   (let ((browse-url-browser-function 'browse-url-default-browser))
                                     (call-interactively 'browse-url))))

(global-unset-key (kbd "M-l"))
(global-set-key (kbd "M-l a") 'custom-layout1)
(global-set-key (kbd "M-l b") 'custom-layout2)
(global-set-key (kbd "\C-xb")
                '(lambda ()
                   (interactive)
                   (ido-mode 1)
                   (ido-switch-buffer)))
(global-set-key (kbd "\C-x\C-f")
                '(lambda ()
                   (interactive)
                   (ido-mode 1)
                   (ido-find-file)))

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
