;;; packages.el --- my-ace-isearch layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: sysmanj <sysmanj@sysmanj-Aspire-E5-575>
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
;; added to `my-ace-isearch-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-ace-isearch/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-ace-isearch/pre-init-PACKAGE' and/or
;;   `my-ace-isearch/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-ace-isearch-packages
  '(ace-isearch helm-swoop)
  "The list of Lisp packages required by the my-ace-isearch layer.

  ;; My incsearched setup worked seamlessly good:
  ;; helm-swoop-20180215.1154
  ;; helm-core-20190712.1716
  ;; ace-isearch-20190630.1552
  ;; ace-jump-mode-20140616.815
Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


;;; packages.el ends here
(defun my-ace-isearch/init-ace-isearch ()
  (use-package
    ace-isearch
    :ensure t
    :init (defconst ace-isearch-normal-input-length 3)
    (defconst ace-isearch-infinity-input-length 140)
    (defun toggle-helm-swoop-autojum ()
      (interactive)
      (if (equal ace-isearch-input-length ace-isearch-normal-input-length)
          (progn (message "toggling helm-swoop isearch autojump to : OFF")
                 (setq ace-isearch-input-length ace-isearch-infinity-input-length))
        (message "toggling helm-swoop isearch autojump to : ON")
        (setq ace-isearch-input-length ace-isearch-normal-input-length)))
    :config (global-ace-isearch-mode +1)
    (custom-set-variables '(ace-isearch-function 'ace-jump-word-mode)
                          '(ace-isearch-use-jump nil)
                          '(ace-isearch-input-length ace-isearch-normal-input-length)
                          '(ace-isearch-jump-delay 1.5)
                          '(ace-isearch-function-from-isearch 'helm-swoop-from-isearch-override)
                          ;; '(search-nonincremental-instead nil)
                          )
    (define-key isearch-mode-map (kbd "C-j") 'ace-isearch-jump-during-isearch-helm-swoop)
    (define-key isearch-mode-map (kbd "RET") 'ace-isearch-jump-during-isearch-helm-swoop)
    (define-key isearch-mode-map (kbd "<return>") 'ace-isearch-jump-during-isearch-helm-swoop)
    (define-key helm-swoop-map (kbd "C-j") '(lambda nil (interactive) (helm-select-nth-action 0)))
    (define-key helm-swoop-map (kbd "RET") 'ace-isearch-jump-during-isearch-helm-swoop)
    (define-key helm-swoop-map (kbd "<return>") 'ace-isearch-jump-during-isearch-helm-swoop)
    (spacemacs/set-leader-keys "t]" 'toggle-helm-swoop-autojum)
    (evil-global-set-key 'normal (kbd "/") 'isearch-forward)
    (evil-global-set-key 'normal (kbd "?") 'isearch-backward)
    (with-eval-after-load 'evil-evilified-state (define-key evil-evilified-state-map-original "/"
                                                  'isearch-forward)
                         (define-key evil-evilified-state-map-original "?" 'isearch-backward)
                          (key-chord-define evil-evilified-state-map-original "//" 'rep-isearch-forward)
                          (key-chord-define evil-evilified-state-map-original "??" 'rep-isearch-backward))
    (with-eval-after-load 'evil-states (define-key evil-motion-state-map "/"
                                                  'isearch-forward)
                          (define-key evil-motion-state-map "?" 'isearch-backward)
                          (key-chord-define evil-motion-state-map "//" 'rep-isearch-forward)
                          (key-chord-define evil-motion-state-map "??" 'rep-isearch-backward))
    (key-chord-define evil-normal-state-map "//" 'rep-isearch-forward)
    (key-chord-define evil-normal-state-map "??" 'rep-isearch-backward)))

(defun my-ace-isearch/post-init-ace-isearch ()
  (defun ace-isearch--jumper-function ()
    (cond ((and
            (= (length isearch-string) 1)
            (not (or isearch-regexp
                     (ace-isearch--isearch-regexp-function)))
            (ace-isearch--fboundp ace-isearch-function (or (eq ace-isearch-use-jump t)
                                                           (and (eq ace-isearch-use-jump
                                                                    'printing-char)
                                                                (eq this-command
                                                                    'isearch-printing-char))))
            (sit-for ace-isearch-jump-delay))
           (isearch-exit)
           ;; go back to the point where isearch started
           (goto-char isearch-opoint)
           (if (or (< (point)
                      (window-start))
                   (> (point)
                      (window-end)))
               (message
                "Notice: Character '%s' could not be found in the \"selected visible window\"."
                isearch-string))
           (funcall ace-isearch-function (string-to-char isearch-string))
           ;; work-around for emacs 25.1
           (setq isearch--current-buffer (buffer-name (current-buffer)) isearch-string ""))
          ((and
            (> (length isearch-string) 1)
            (< (length isearch-string) ace-isearch-input-length)
            (not isearch-success)
            (sit-for ace-isearch-jump-delay))
           (if (ace-isearch--fboundp ace-isearch-fallback-function
                 ace-isearch-use-fallback-function)
               (funcall ace-isearch-fallback-function)))
          ((and
            (>= (length isearch-string) ace-isearch-input-length)
            ;; (not isearch-regexp)
            (ace-isearch--fboundp ace-isearch-function-from-isearch
              ace-isearch-use-function-from-isearch)
            (sit-for ace-isearch-func-delay))
           (isearch-exit)
           (funcall ace-isearch-function-from-isearch)
           ;; work-around for emacs 25.1
           (setq isearch--current-buffer (buffer-name (current-buffer)) isearch-string "")))))

(defun my-ace-isearch/post-init-helm-swoop ()
  (defvar helm-swoop-pattern "")        ; Keep helm-pattern value
  (add-hook 'helm-exit-minibuffer-hook '(lambda ()
                                          (if isearch-regexp
                                              (setq regexp-search-ring (cons helm-swoop-pattern
                                                                             regexp-search-ring))
                                            (setq search-ring (cons helm-swoop-pattern
                                                                    search-ring))))))
