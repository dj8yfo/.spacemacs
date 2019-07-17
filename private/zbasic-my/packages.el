;;; packages.el --- zbasic-my layer packages file for Spacemacs.
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

(defconst zbasic-my-packages
  '(key-chord ggtags ace-jump-mode ace-isearch)
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
(defun zbasic-my/init-key-chord ()
  (use-package key-chord
    :ensure t
    :config
    (key-chord-mode 1)
    (key-chord-define-global "gh" 'ace-jump-word-mode)
    (key-chord-define-global "gl" 'ace-jump-line-mode)
    (key-chord-define-global "gk" 'ace-jump-char-mode))
  	(key-chord-define-global "uu" 'undo-tree-visualize)
    (key-chord-define-global "yy" 'helm-show-kill-ring)
  )

(defun zbasic-my/post-init-ggtags ()

  (add-hook 'ggtags-mode-hook '(lambda ()
                                 (evil-global-set-key 'normal (kbd "M-.") 'helm-gtags-dwim)
                                 (evil-global-set-key 'insert (kbd "M-.") 'helm-gtags-dwim)))

  (spacemacs/set-leader-keys "gd" 'helm-gtags-find-tag)
  (spacemacs/set-leader-keys "gR" 'helm-gtags-resume)
  (spacemacs/set-leader-keys "gs" 'helm-gtags-select)
  (spacemacs/set-leader-keys "gp" 'helm-gtags-previous-history)
  (spacemacs/set-leader-keys "gn" 'helm-gtags-next-history)
  (spacemacs/set-leader-keys "gD" 'helm-gtags-find-tag-other-window)
  (spacemacs/set-leader-keys "gy" 'helm-gtags-find-symbol)
  (spacemacs/set-leader-keys "gu" 'helm-gtags-update-tags)

  )



(defun zbasic-my/init-ace-jump-mode ()
  (use-package ace-jump-mode
    :defer t
    :ensure t)
  )

(defun zbasic-my/init-ace-isearch ()
  (use-package ace-isearch
    :ensure t
    :config
    (global-ace-isearch-mode +1)
    (custom-set-variables
     '(ace-isearch-function 'ace-jump-word-mode)
                          '(ace-isearch-use-jump nil)
                          '(ace-isearch-input-length 5)
                          '(ace-isearch-jump-delay 1.5)
                          '(ace-isearch-function-from-isearch 'helm-swoop-from-isearch)
                          )
    (define-key isearch-mode-map (kbd "C-j") 'ace-isearch-jump-during-isearch-helm-swoop)
    (define-key helm-swoop-map (kbd "C-j") 'ace-isearch-jump-during-isearch-helm-swoop)
    (evil-global-set-key 'normal (kbd "/") 'isearch-forward)
    (evil-global-set-key 'normal (kbd "?") 'isearch-backward)
    (key-chord-define-global "//" 'rep-isearch-forward)
    (key-chord-define-global "??" 'rep-isearch-backward)
    )
  )
