(toggle-browse-eww-system-browser 2)
(advice-add 'server-create-window-system-frame
            :after '(lambda
                      (&rest
                       args)
                      (interactive)
                      (set-default-font "-xos4-terminus-medium-r-normal--14-*-72-72-c-80-koi8-r" nil
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
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(require 'personal-sysj-notes-exporter "notes.el")
(setq org-agenda-files (list (concat notes-org-dir "real_life.org")))
(setq purpose-layout-dirs '("/home/hypen9/Documents/.spacemacs/private/my-basic/layouts/"))
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux")))

(with-eval-after-load 'company
  (setq company-dabbrev-ignore-case t))
(with-eval-after-load 'eww
  (setq eww-history-limit 10000))

(with-eval-after-load 'evil (dolist (sym jumping-commands-list)
                              (add-jump-push-action sym))
                      (evil-define-operator
                        evil-upcase
                        (beg end type)
                        "Convert text to upper case."
                        :move-point nil
                        (if (eq type 'block)
                            (evil-apply-on-block #'evil-upcase beg end nil)
                          (upcase-region beg end)))
                      (evil-define-operator
                        evil-downcase
                        (beg end type)
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


(with-eval-after-load 'symbol-overlay (face-spec-set 'symbol-overlay-face-1 '((t
                                                                               (:weight ultrabold
                                                                                        :background
                                                                                        "black"
                                                                                        :foreground
                                                                                        "dodger blue"))))
                      (face-spec-set 'symbol-overlay-face-2 '((t
                                                               (:weight ultrabold
                                                                        :background "black"
                                                                        :foreground "hot pink"))))
                      (face-spec-set 'symbol-overlay-face-3 '((t
                                                               (:weight ultrabold
                                                                        :background "black"
                                                                        :foreground "yellow"))))
                      (face-spec-set 'symbol-overlay-face-4 '((t
                                                               (:weight ultrabold
                                                                        :background "black"
                                                                        :foreground "orchid"))))
                      (face-spec-set 'symbol-overlay-face-5 '((t
                                                               (:weight ultrabold
                                                                        :background "black"
                                                                        :foreground "red"))))
                      (face-spec-set 'symbol-overlay-face-6 '((t
                                                               (:weight ultrabold
                                                                        :background "black"
                                                                        :foreground "salmon"))))
                      (face-spec-set 'symbol-overlay-face-7 '((t
                                                               (:weight ultrabold
                                                                        :background "black"
                                                                        :foreground "spring green"))))
                      (face-spec-set 'symbol-overlay-face-8 '((t
                                                               (:weight ultrabold
                                                                        :background "black"
                                                                        :foreground "turquoise"))))
                      (defface symbol-overlay-face-9
                        '((t
                           (:weight ultrabold
                                    :background "black"
                                    :foreground "light salmon")))
                        "Symbol Overlay default candidate 1"
                        :group 'symbol-overlay)
                      (defface symbol-overlay-face-10
                        '((t
                           (:weight ultrabold
                                    :background "black"
                                    :foreground "tomato")))
                        "Symbol Overlay default candidate 1"
                        :group 'symbol-overlay)
                      (setq symbol-overlay-faces '(symbol-overlay-face-1 symbol-overlay-face-2
                                                                         symbol-overlay-face-3
                                                                         symbol-overlay-face-4
                                                                         symbol-overlay-face-5
                                                                         symbol-overlay-face-6
                                                                         symbol-overlay-face-7
                                                                         symbol-overlay-face-8
                                                                         symbol-overlay-face-9
                                                                         symbol-overlay-face-10)))

(defvar highlight-regex-faces
  '(symbol-overlay-face-1 symbol-overlay-face-2 symbol-overlay-face-3 symbol-overlay-face-4
                          symbol-overlay-face-5 symbol-overlay-face-6 symbol-overlay-face-7
                          symbol-overlay-face-8 symbol-overlay-face-9 symbol-overlay-face-10))
(with-eval-after-load 'ace-jump-mode (face-spec-set 'ace-jump-face-foreground  '((t
                                                                                  (:weight light
                                                                                           :background
                                                                                           "black"
                                                                                           :foreground
                                                                                           "springgreen")))))
(with-eval-after-load 'helm (face-spec-set 'helm-selection  '((t
                                                               (:weight light
                                                                        :foreground "cyan"
                                                                        :background "gray22"))))
                      (face-spec-set 'helm-header  '((t
                                                      (:weight light
                                                               :foreground "white"
                                                               :background "black"))))
                      (face-spec-set 'helm-match  '((t
                                                     (:weight bold
                                                              :foreground "steel grey"
                                                              :background "black")))))
(with-eval-after-load 'helm-swoop (face-spec-set 'helm-swoop-target-word-face  '((t
                                                                                  (:weight bold
                                                                                           :foreground
                                                                                           "steel grey"
                                                                                           :background
                                                                                           "black"))))
                      (face-spec-set 'helm-swoop-target-line-face  '((t
                                                                      (:weight light
                                                                               :background "gray20"
                                                                               :foreground "deep pink")))))




(defvar highlight-regex-faces-num (length highlight-regex-faces))
(defvar highlight-regex-faces-ind 0)
(with-eval-after-load 'faces (face-spec-set 'line-number  '((t
                                                             (:weight ultralight
                                                                      :background "gray22"
                                                                      :foreground "white"))))
                      (face-spec-set 'region '((t
                                                (:foreground "cyan"
                                                             :background "black")))))

(with-eval-after-load 'flycheck (face-spec-set 'flycheck-error '((t
                                                                  (:weight ultralight
                                                                           :background "gray22"
                                                                           :foreground "#FF5F87"))))
                      (face-spec-set 'flycheck-warning '((t
                                                          (:weight ultralight
                                                                   :background "gray22"
                                                                   :foreground "#FFFF87"))))
                      (face-spec-set 'flycheck-error-list-highlight '((t
                                                                       (:background "black"
                                                                                    :foreground
                                                                                    "white")))))
(with-eval-after-load 'font-lock (face-spec-set 'font-lock-comment-face '((t
                                                                           (:weight ultralight
                                                                                    :background
                                                                                    "gray22"
                                                                                    :foreground
                                                                                    "white"))))
                      (face-spec-set 'font-lock-doc-face '((t
                                                            (:weight ultralight
                                                                     :background "gray22"
                                                                     :foreground "white")))))

(with-eval-after-load 'company (face-spec-set 'company-tooltip-selection '((t
                                                                            (:background "black"
                                                                                         :foreground
                                                                                         "white")))))

(with-eval-after-load 'faces (face-spec-set 'show-paren-match '((t
                                                                 (:underline t :foreground "violet"
                                                                              :background "black"))))
                      (face-spec-set 'show-paren-mismatch '((t
                                                             (:foreground "turquoise"
                                                                          :background "yellow")))))

(with-eval-after-load 'ediff-init (face-spec-set 'ediff-odd-diff-A '((t
                                                                      (:background "gray"))))
                      (face-spec-set 'ediff-odd-diff-B '((t
                                                          (:background "gray"))))
                      (face-spec-set 'ediff-odd-diff-C '((t
                                                          (:background "gray"))))
                      (face-spec-set 'ediff-even-diff-A '((t
                                                           (:background "gray"))))
                      (face-spec-set 'ediff-even-diff-B '((t
                                                           (:background "gray"))))
                      (face-spec-set 'ediff-even-diff-C '((t
                                                           (:background "gray")))))
(with-eval-after-load 'evil-search-highlight-persist (face-spec-set
                                                      'evil-search-highlight-persist-highlight-face
                                                      '((t
                                                         (:background "magenta"
                                                                      :foreground "black"
                                                                      :inverse nil)))))
(with-eval-after-load 'imenu-list (face-spec-set 'imenu-list-entry-face '((t
                                                                           (:background "gray22"))))
                      (face-spec-set 'imenu-list-entry-face-0 '((t
                                                                 (:foreground "color-201"))))
                      (face-spec-set 'imenu-list-entry-face-1 '((t
                                                                 (:foreground "color-220"))))
                      (face-spec-set 'imenu-list-entry-face-2 '((t
                                                                 (:foreground "color-190"))))
                      (face-spec-set 'imenu-list-entry-face-3 '((t
                                                                 (:foreground "color-159")))))
(with-eval-after-load 'evil-matchit
  (setq evilmi-quote-chars (list 39 34 47 96)))

(with-eval-after-load 'vc-hooks
  (setq vc-follow-symlinks t))
(with-eval-after-load 'column-enforce-mode
  (setq column-enforce-column 100))
(add-hook 'window-setup-hook 'on-after-init)
(add-hook 'prog-mode-hook 'spacemacs/toggle-relative-line-numbers-on)
(add-hook 'python-mode-hook '(lambda ()
                               (setq flycheck-checkers (delete 'python-mypy flycheck-checkers))))
(setq-default frame-title-format "%b (%f)")

(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(with-eval-after-load 'rainbow-delimiters (face-spec-set 'rainbow-delimiters-depth-1-face '((t
                                                                                   (:foreground
                                                                                    "lime green"))))
                      (face-spec-set 'rainbow-delimiters-depth-2-face '((t
                                                                         (:foreground
                                                                          "green yellow"))))
                      (face-spec-set 'rainbow-delimiters-depth-3-face '((t
                                                                         (:foreground
                                                                          "khaki"))))
                      (face-spec-set 'rainbow-delimiters-depth-4-face '((t
                                                                         (:foreground
                                                                          "light steel blue"))))
                      (face-spec-set 'rainbow-delimiters-depth-5-face '((t
                                                                         (:foreground
                                                                          "grey"))))
                      (face-spec-set 'rainbow-delimiters-depth-6-face '((t
                                                                         (:foreground
                                                                          "medium orchid"))))
                      (face-spec-set 'rainbow-delimiters-depth-7-face '((t
                                                                         (:foreground
                                                                          "orchid"))))
                      )

(setq pylookup-db-file "/home/hypen9/Documents/code/pylookup/pylookup.db")
