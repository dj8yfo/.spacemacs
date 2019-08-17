;;; packages.el --- my-basic layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: sj <sysmanj@sysmanj-a>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `basic-my-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `basic-my/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `basic-my/pre-init-PACKAGE' and/or
;;   `basic-my/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-basic-packages
  '(key-chord ggtags ace-jump-mode helm helm-elisp evil-goggles org-alert helm-rg
              (my-autocolor-html-pre-code-tags :location local))
  "The list of Lisp packages required by the basic-my layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      Theher-window following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

;;; packages.el ends here
(defun my-basic/init-key-chord ()
  (use-package
    key-chord
    :ensure t
    :config (key-chord-mode 1)
    (key-chord-define evil-normal-state-map "gh" 'ace-jump-char-mode)
    (key-chord-define evil-normal-state-map "gl" 'ace-jump-line-mode)
    (key-chord-define evil-normal-state-map "gk" 'ace-jump-word-mode)
    (key-chord-define-global "UU" 'undo-tree-visualize)
    (key-chord-define-global "yy" 'helm-show-kill-ring)))

(defun my-basic/post-init-ggtags ()
  (add-hook 'ggtags-mode-hook '(lambda ()
                                 (define-key ggtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
                                 (define-key ggtags-mode-map (kbd "M-]")
                                   'helm-gtags-dwim-other-window)))
  (setq gtags-enable-by-default nil))



(defun my-basic/init-ace-jump-mode ()
  (use-package
    ace-jump-mode
    :defer t
    :ensure t))


(defun my-basic/post-init-helm ()
  (define-key helm-map (kbd "C-l") 'kill-backward-until-sep))

(defun my-basic/post-init-evil-goggles ()
  (evil-goggles-mode 1)
  (setq evil-goggles-duration 0.3)
  (setq evil-goggles-async-duration 3)
  (evil-goggles-use-diff-faces))

(defun my-basic/init-org-alert ()
  (use-package
    org-alert
    :ensure t
    :config (progn (org-alert-enable)
                   (setq alert-default-style 'libnotify))))


(defun my-basic/init-helm-rg ()
  (use-package
    helm-rg
    :defer t
    :commands (helm-rg)))

(defun my-basic/init-my-autocolor-html-pre-code-tags ()
  (use-package
    my-autocolor-html-pre-code-tags
    :after shr
    :load-path "private/my-basic/local/my-autocolor-html-pre-code-tags"))


(defun my-basic/post-init-helm-elisp ()
  (setq helm-source-complex-command-history
        (helm-build-sync-source "Complex Command History" 
          :candidates (lambda ()
                        ;; Use cdr to avoid adding
                        ;; `helm-complex-command-history' here.
                        (cl-loop for i in command-history unless (equal i
                                                                        '(helm-complex-command-history))
                                 collect (prin1-to-string i)))
          :action (helm-make-actions "Eval" (lambda (candidate) 
                                              (and (boundp 'helm-sexp--last-sexp) 
                                                   (setq helm-sexp--last-sexp candidate)) 
                                              (let ((command (read candidate))) 
                                                (unless (equal command (car command-history)) 
                                                  (setq command-history (cons command
                                                                              command-history))))
                                              (run-with-timer 0.1 nil #'helm-sexp-eval candidate))
                                     "Edit and eval" (lambda (candidate)
                                                       (edit-and-eval-command "Eval: " (read
                                                                                        candidate)))
                                     "insert" (lambda (candidate)
                                                (insert candidate))) 
          :persistent-action #'helm-sexp-eval 
          :multiline t)))
