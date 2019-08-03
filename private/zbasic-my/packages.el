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
  '(key-chord ggtags ace-jump-mode helm ace-isearch helm-swoop evil-goggles android-env helm-dash)


  ;; My incsearched setup worked seamlessly good:
  ;; helm-swoop-20180215.1154
  ;; helm-core-20190712.1716
  ;; ace-isearch-20190630.1552
  ;; ace-jump-mode-20140616.815
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
  (use-package
    key-chord
    :ensure t
    :config (key-chord-mode 1)
    (key-chord-define evil-normal-state-map "gh" 'ace-jump-char-mode)
    (key-chord-define evil-normal-state-map "gl" 'ace-jump-line-mode)
    (key-chord-define evil-normal-state-map "gk" 'ace-jump-word-mode)
    (key-chord-define-global "UU" 'undo-tree-visualize)
    (key-chord-define-global "yy" 'helm-show-kill-ring)))

(defun zbasic-my/post-init-ggtags ()
  (add-hook 'ggtags-mode-hook '(lambda ()
                                 (evil-global-set-key 'normal (kbd "M-.") 'helm-gtags-dwim)
                                 (evil-global-set-key 'insert (kbd "M-.") 'helm-gtags-dwim)
                                 (evil-global-set-key 'normal (kbd "M-]")
                                                      'helm-gtags-dwim-other-window)
                                 (evil-global-set-key 'insert (kbd "M-]")
                                                      'helm-gtags-dwim-other-window)))
  (setq gtags-enable-by-default nil)
  (spacemacs/set-leader-keys "gd" 'helm-gtags-find-tag)
  (spacemacs/set-leader-keys "gR" 'helm-gtags-resume)
  (spacemacs/set-leader-keys "gs" 'helm-gtags-select)
  (spacemacs/set-leader-keys "gp" 'helm-gtags-previous-history)
  (spacemacs/set-leader-keys "gn" 'helm-gtags-next-history)
  (spacemacs/set-leader-keys "gD" 'helm-gtags-find-tag-other-window)
  (spacemacs/set-leader-keys "gy" 'helm-gtags-find-symbol)
  (spacemacs/set-leader-keys "gu" 'helm-gtags-update-tags))



(defun zbasic-my/init-ace-jump-mode ()
  (use-package
    ace-jump-mode
    :defer t
    :ensure t))

(defun zbasic-my/init-ace-isearch ()
  (use-package
    ace-isearch
    :ensure t
    :init (defconst ace-isearch-normal-input-length 5)
    (defconst ace-isearch-infinity-input-length 140)
    (defun toggle-helm-swoop-autojum ()
      (interactive)
      (if (equal ace-isearch-input-length ace-isearch-normal-input-length)
          (progn
            (message "toggling helm-swoop isearch autojump to : OFF")
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
    (define-key helm-swoop-map (kbd "C-j") 'ace-isearch-jump-during-isearch-helm-swoop)
    (define-key helm-swoop-map (kbd "RET") 'ace-isearch-jump-during-isearch-helm-swoop)
    (define-key helm-swoop-map (kbd "<return>") 'ace-isearch-jump-during-isearch-helm-swoop)
    (spacemacs/set-leader-keys "t]" 'toggle-helm-swoop-autojum)
    (evil-global-set-key 'normal (kbd "/") 'isearch-forward)
    (evil-global-set-key 'normal (kbd "?") 'isearch-backward)
    (key-chord-define evil-normal-state-map "//" 'rep-isearch-forward)
    (key-chord-define evil-normal-state-map "??" 'rep-isearch-backward)))

(defun zbasic-my/post-init-helm-swoop ()
  (defvar helm-swoop-pattern "")        ; Keep helm-pattern value
  (add-hook 'helm-exit-minibuffer-hook '(lambda ()
                                          (if isearch-regexp
                                              (setq regexp-search-ring (cons helm-swoop-pattern
                                                                             regexp-search-ring))
                                            (setq search-ring (cons helm-swoop-pattern
                                                                    search-ring))))))

(defun zbasic-my/post-init-ace-isearch ()
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


(defun zbasic-my/post-init-helm ()
  (define-key helm-map (kbd "C-l") 'kill-backward-until-sep))

(defun zbasic-my/init-evil-goggles ()
  (use-package
    evil-goggles
    :ensure t
    :config (progn (evil-goggles-mode)
                   ;; (evil-goggles-use-diff-faces)
                   (setq evil-goggles-duration 0.3)
                   (setq evil-goggles-async-duration 1.2))


    ;; optionally use diff-mode's faces; as a result, deleted text
    ;; will be highlighed with `diff-removed` face which is typically
    ;; some red color (as defined by the color theme)
    ;; other faces such as `diff-added` will be used for other actions
    ))

(defun zbasic-my/init-android-env ()
  (use-package
    android-env
    :after hydra
    :bind (("C-c a" . hydra-android/body))
    :config (defvar hydra-android nil)
    (setq android-env-executable "./gradlew")
    (setq android-env-test-command "connectedDevDebugAndroidTest")
    (setq android-env-unit-test-command "testDevDebug")
    (defun android-env-hydra-setup ()
      "Hydra setup."
      (when
          (require 'hydra nil 'noerror)
        (defhydra hydra-android
          (:color pink
                  :hint nil)
          "
^Compiling^              ^Devices^       ^Code^                   ^Logcat^           ^Adb^
^^^^^----------------------------------------------------------------------------------------------
_w_: Compile             _e_: Avd        _r_: Refactor            _l_: Logcat        _U_: Uninstall
_s_: Instrumented Test   _d_: Auto DHU   _R_: Recursive refactor  _c_: Logcat crash  _L_: Deep link
_u_: Unit Test           ^ ^             ^ ^                      _C_: Logcat clear
_t_: Single unit test
_x_: Crashlytics
" ("w" android-env-compile)
("s" android-env-test)
("u" android-env-unit-test)
("e" android-env-avd)
("d" android-env-auto-dhu)
("l" android-env-logcat)
("c" android-env-logcat-crash)
("C" android-env-logcat-clear)
("t" android-env-unit-test-single)
("x" android-env-crashlytics)
("U" android-env-uninstall-app)
("L" android-env-deeplink)
("r" android-env-refactor)
("R" android-env-recursive-refactor)
("q" nil "quit"))))
    (android-env)))

(defun zbasic-my/init-helm-dash ()
  (use-package
    helm-dash
    :defer t
    :config (progn (helm-dash-activate-docset "Java")
                   (helm-dash-activate-docset "kotlin"))))
