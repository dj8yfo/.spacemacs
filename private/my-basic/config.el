(toggle-browse-eww-system-browser 2)
(advice-add 'server-create-window-system-frame
            :after '(lambda
                      (&rest
                       args)
                      (interactive)
                      (set-default-font
                       "-ADBO-Hasklig-extralight-normal-normal-*-15-*-*-*-m-0-iso10646-1"
                       nil nil)))
;test commit
(custom-set-variables '(helm-ag-base-command "rg --no-heading -L -S --no-ignore --hidden"))
(defvar jumping-commands-list
  '(evil-backward-word-begin evil-forward-word-begin evil-ace-jump-char-mode evil-ace-jump-line-mode
                             evil-ace-jump-word-mode find-file
                             evil-snipe-repeat evil-next-respect-isearch
                             evil-previous-respect-isearch evil-snipe-f evil-snipe-F evil-snipe-t
                             evil-snipe-T evil-snipe-s evil-snipe-S evil-previous-line
                             evil-next-line helm-gtags-dwim xref-find-definitions
                             goto-sources-regex-dir))
(if (display-graphic-p) nil
  (setq    dotspacemacs-mode-line-theme '(vim-powerline :separator slant
                                                        :separator-scale 1.1)))
(setq evil-escape-key-sequence "z[")
(setq list-command-history-max 10000 evil-jumps-max-length 1000)

(add-to-list 'load-path (expand-file-name "private/my-basic" user-emacs-directory))
(require 'personal-sysj-notes-exporter "notes.el")
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
(with-eval-after-load 'magit (global-diff-hl-mode 1))
(with-eval-after-load 'shr
  (setq shr-use-fonts nil))
(with-eval-after-load 'volatile-highlights (volatile-highlights-mode -1))
(with-eval-after-load 'window-purpose
                      (add-to-list 'purpose-user-mode-purposes '(eww-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(eww-history-mode . eww-history))
                      (add-to-list 'purpose-user-mode-purposes '(lisp-interaction-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(messages-buffer-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(compilation-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(Man-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(ibuffer-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(fundamental-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(org-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(help-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(kotlin-mode . edit))
                      (add-to-list 'purpose-user-mode-purposes '(dired-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(doc-view-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(flymake-diagnostics-buffer-mode .
                                                                                                 edit1))
                      (add-to-list 'purpose-user-mode-purposes '(magit-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(ggtags-global-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(ivy-occur-grep-mode . org))
                      (purpose-compile-user-configuration))
;; (custom-layout2)

(defvar highlight-regex-faces (list 'anzu-match-1 'anzu-match-2 'anzu-match-3
                                    'avy-lead-face 'avy-lead-face-0 'avy-lead-face-1 'avy-lead-face-2))
(defvar highlight-regex-faces-num 7)
(defvar highlight-regex-faces-ind 0)
