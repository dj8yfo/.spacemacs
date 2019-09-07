(toggle-browse-eww-system-browser 2)
(advice-add 'server-create-window-system-frame
            :after '(lambda
                      (&rest
                       args)
                      (interactive)
                      (set-default-font
                       "-ADBO-Source Code Pro-light-normal-normal-*-15-*-*-*-m-0-iso10646-1"    nil
                       nil)))
                                        ;test commit
(custom-set-variables '(helm-ag-base-command "rg --no-heading -z -L -S --no-ignore --hidden"))
(defvar jumping-commands-list
  '(evil-backward-word-begin evil-forward-word-begin evil-ace-jump-char-mode evil-ace-jump-line-mode
                             evil-ace-jump-word-mode find-file evil-snipe-repeat
                             evil-next-respect-isearch evil-previous-respect-isearch evil-snipe-f
                             evil-snipe-F evil-snipe-t evil-snipe-T evil-snipe-s evil-snipe-S
                             evil-previous-line evil-next-line helm-gtags-dwim xref-find-definitions
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
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "stroustrup")))

(with-eval-after-load 'company
  (setq company-dabbrev-ignore-case t))

(with-eval-after-load 'evil (dolist (sym jumping-commands-list)
                              (add-jump-push-action sym))
                      (evil-define-operator evil-upcase (beg end type)
                        "Convert text to upper case."
                        :move-point nil
                        (if (eq type 'block)
                            (evil-apply-on-block #'evil-upcase beg end nil)
                          (upcase-region beg end)))
                      (evil-define-operator evil-downcase (beg end type)
                        "Convert text to lower case."
                        :move-point nil
                        (if (eq type 'block)
                            (evil-apply-on-block #'evil-downcase beg end nil)
                          (downcase-region beg end)))
                      (setq evil-move-cursor-back nil evil-want-fine-undo t
                            evil-operator-state-cursor '("red" evil-half-cursor)))
(add-jump-push-action 'evil-backward-word-begin)
(with-eval-after-load 'evil-states
  (setq evil-emacs-state-modes (delete 'ibuffer-mode evil-emacs-state-modes )))
(with-eval-after-load 'helm-elisp)
(with-eval-after-load 'magit (global-diff-hl-mode 1))
(with-eval-after-load 'shr
  (setq shr-use-fonts nil))
(with-eval-after-load 'volatile-highlights (volatile-highlights-mode -1))
(with-eval-after-load 'window-purpose (add-to-list 'purpose-user-mode-purposes '(eww-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(eww-history-mode . eww-history))
                      (add-to-list 'purpose-user-mode-purposes '(lisp-interaction-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(helm-occur-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(spacemacs-buffer-mode . edit))
                      (add-to-list 'purpose-user-mode-purposes '(messages-buffer-mode . org))
                      (add-to-list 'purpose-user-mode-purposes '(compilation-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(flycheck-error-list-mode . edit1))
                      (add-to-list 'purpose-user-mode-purposes '(helm-occur-mode . edit1))
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

(defvar highlight-regex-faces
  (list 'eshell-ls-archive 'eshell-ls-backup 'eshell-ls-clutter 'eshell-ls-directory
        'eshell-ls-executable 'eshell-ls-missing 'eshell-ls-product 'eshell-ls-readonly
        'eshell-ls-special 'eshell-ls-symlink))


(defvar highlight-regex-faces-num (length highlight-regex-faces))
(defvar highlight-regex-faces-ind 0)

(with-eval-after-load 'symbol-overlay

  (face-spec-set 'symbol-overlay-face-1 '((t
                                    (:weight ultrabold :background "dodger blue"
                                                 :foreground "black")))
    )

  (face-spec-set 'symbol-overlay-face-2 '((t
                                           (:weight ultrabold :background "hot pink"
                                                    :foreground "black")))
                 )
  (face-spec-set 'symbol-overlay-face-3 '((t
                                    (:weight ultrabold :background "yellow"
                                                 :foreground "black")))
                 )

  (face-spec-set 'symbol-overlay-face-4 '((t
                                    (:weight ultrabold :background "orchid"
                                                 :foreground "black")))
                 )

  (face-spec-set 'symbol-overlay-face-5 '((t
                                    (:weight ultrabold :background "red"
                                                 :foreground "black")))
                 )

  (face-spec-set 'symbol-overlay-face-6 '((t
                                    (:weight ultrabold :background "salmon"
                                                 :foreground "black")))
                 )

  (face-spec-set 'symbol-overlay-face-7 '((t
                                    (:weight ultrabold :background "spring green"
                                                 :foreground "black")))
                 )

  (face-spec-set 'symbol-overlay-face-8 '((t
                                    (:weight ultrabold :background "turquoise"
                                                 :foreground "black")))
                 )
  (defface symbol-overlay-face-9 '((t
                                    (:weight ultrabold :background "light salmon"
                                                 :foreground "black")))
    "Symbol Overlay default candidate 1"
    :group 'symbol-overlay)
  (defface symbol-overlay-face-10 '((t
                                     (:weight ultrabold :background "tomato"
                                                  :foreground "black")))
    "Symbol Overlay default candidate 1"
    :group 'symbol-overlay)
  (setq symbol-overlay-faces '(symbol-overlay-face-1 symbol-overlay-face-2 symbol-overlay-face-3
                                                     symbol-overlay-face-4 symbol-overlay-face-5
                                                     symbol-overlay-face-6 symbol-overlay-face-7
                                                     symbol-overlay-face-8 symbol-overlay-face-9
                                                     symbol-overlay-face-10)))
