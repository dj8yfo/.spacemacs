(toggle-browse-eww-system-browser 2)
(advice-add 'server-create-window-system-frame
            :after '(lambda
                      (&rest
                       args)
                      (interactive)
                      (set-default-font
                       "-xos4-Terminess Powerline-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1"
                       nil nil)))
(custom-set-variables '(helm-ag-base-command "rg --no-heading -L --no-ignore --hidden")
                      )
(defvar jumping-commands-list
  '(evil-backward-word-begin evil-forward-word-begin evil-ace-jump-char-mode evil-ace-jump-line-mode
buff                             evil-ace-jump-word-mode find-file evil-snipe-repeat
                             evil-next-respect-isearch evil-previous-respect-isearch evil-snipe-f
                             evil-snipe-F evil-snipe-t evil-snipe-T evil-snipe-s evil-snipe-S
                             evil-previous-line evil-next-line helm-gtags-dwim xref-find-definitions
                             goto-sources-regex-dir))
(if (display-graphic-p) nil
  (setq    dotspacemacs-mode-line-theme '(vim-powerline :separator slant
                                                        :separator-scale 1.1)))
(setq evil-escape-key-sequence "z[")
(setq list-command-history-max 10000)
(load-file "private/my-basic/notes.el")
(setq org-agenda-files (list (concat notes-org-dir "notes.org")))
(setq purpose-layout-dirs '("/home/sysmanj/Documents/.spacemacs/private/my-basic/layouts/"))

(with-eval-after-load 'company
  (setq company-dabbrev-ignore-case t))

(with-eval-after-load 'evil (dolist (sym jumping-commands-list)
                              (add-jump-push-action sym)))
(add-jump-push-action 'evil-backward-word-begin)
(with-eval-after-load 'evil-states
  (setq evil-emacs-state-modes (delete 'ibuffer-mode evil-emacs-state-modes )))
(with-eval-after-load 'helm-elisp)
(with-eval-after-load 'imenu
  (setq-default imenu-create-index-function #'ggtags-build-imenu-index))
(with-eval-after-load 'magit (global-diff-hl-mode 1))
(with-eval-after-load 'shr
  (setq shr-use-fonts nil))
(with-eval-after-load 'volatile-highlights (volatile-highlights-mode -1))
(with-eval-after-load 'window-purpose (add-to-list 'purpose-user-mode-purposes '(eshell-mode .
                                                                                             terminal))
                      (add-to-list 'purpose-user-mode-purposes '(compilation-mode . terminal))
                      (add-to-list 'purpose-user-mode-purposes '(ibuffer-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(fundamental-mode . terminal))
                      (add-to-list 'purpose-user-mode-purposes '(org-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(help-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(kotlin-mode . edit))
                      (add-to-list 'purpose-user-mode-purposes '(dired-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(doc-view-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(flymake-diagnostics-buffer-mode .
                                                                                                 edit1))
                      (add-to-list 'purpose-user-mode-purposes '(magit-mode . terminal))
                      (add-to-list 'purpose-user-mode-purposes '(ggtags-global-mode . terminal))
                      (add-to-list 'purpose-user-mode-purposes '(ivy-occur-grep-mode . org))
                      (purpose-compile-user-configuration))
;; (custom-layout2)
