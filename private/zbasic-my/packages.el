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
  '(key-chord ggtags ace-jump-mode helm evil-goggles android-env helm-dash
              kotlin-mode org-alert wordnut dictionary helm-rg engine-mode)


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
  )



(defun zbasic-my/init-ace-jump-mode ()
  (use-package
    ace-jump-mode
    :defer t
    :ensure t))


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
    :commands (helm-dash helm-dash-at-point toggle-helm-dash-search-function)
    :defer t
    :init (progn
            (defun toggle-helm-dash-search-function ()
              (interactive)
              (if (equal helm-dash-browser-func 'eww)
                  (progn (message "setting helm-dash browser to BROWSER")
                         (setq helm-dash-browser-func 'browse-url))
                (message "setting helm-dash browser to EWW")
                (setq helm-dash-browser-func 'eww)))
            (spacemacs/set-leader-keys "dh" 'helm-dash)
            (spacemacs/set-leader-keys "dp" 'helm-dash-at-point)
            (spacemacs/set-leader-keys "dt" 'toggle-helm-dash-search-function))
    :config (progn
              (setq dash-docs-common-docsets '("LaTeX" "C" "Gradle DSL" "Gradle Java API"
                                               "Gradle Groovy API" "Gradle User Guide"
                                               "Android Gradle Plugin" "Python 3" "Android" "kotlin"
                                               "Java"))
              (defun dash-docs-read-json-from-url (url)
                (shell-command (concat "curl -s " url) "*helm-dash-download*")
                (with-current-buffer "*helm-dash-download*" (json-read))))))

(defun zbasic-my/post-init-kotlin-mode ()
  (defvar sources-browse-jump-back nil)
  (defconst kotlin-stdlib-root "/home/sysmanj/Documents/code/kotlin/kotlin-stdlib-sources/")
  (defconst android-src-root "/home/sysmanj/Documents/code/ANDROID_SRC/")
  (defvar indexed-sources-subdir nil)
  (defun goto-sources-regex-dir (regexp subdirarg)
    (interactive "sRegexp:\nDDirectory:")
    (let ((subdirarg (if indexed-sources-subdir indexed-sources-subdir subdirarg)))
      (find-file subdirarg)
      (ggtags-find-tag-regexp regexp subdirarg))
    (setq indexed-sources-subdir nil))
  (advice-add 'goto-sources-query-with-prefix
              :after '(lambda
                        (&rest
                         args)
                        (if sources-browse-jump-back (evil--jumps-jump 0 0))))
  (defun goto-sources-query-with-prefix (arg)
    (interactive "P")
    (let* ((symbol-po-name (format "%s" (if (symbol-at-point)
                                            (symbol-at-point) "")))
           (regexp (if arg (read-string "input symbol name:" symbol-po-name) symbol-po-name)))
      (goto-sources-regex-dir regexp nil)))
  (defhydra hydra-android-sources
    (:color pink
            :hint nil)
    "
^^^^^----------------------------------------------------------------------------------------------
_s_: kotlin-stdlib-peek     _S_: kotlin-stdlib-goto        _a_: frameworks peek   _q_: quit
_A_: frameworks goto
" ("s" (lambda ()
         (interactive)
         (setq sources-browse-jump-back t)
         (setq indexed-sources-subdir kotlin-stdlib-root)
         (call-interactively 'goto-sources-query-with-prefix))
   :exit t)
("S" (lambda ()
       (interactive)
       (setq sources-browse-jump-back nil)
       (setq indexed-sources-subdir kotlin-stdlib-root)
       (call-interactively 'goto-sources-query-with-prefix))
 :exit t)
("a" (lambda ()
       (interactive)
       (setq sources-browse-jump-back t)
       (setq indexed-sources-subdir (concat android-src-root "frameworks"))
       (call-interactively 'goto-sources-query-with-prefix))
 :exit t)
("A" (lambda ()
       (interactive)
       (setq sources-browse-jump-back nil)
       (setq indexed-sources-subdir (concat android-src-root "frameworks"))
       (call-interactively 'goto-sources-query-with-prefix))
 :exit t)
("q" nil "quit"))
  (global-set-key (kbd "C-c y") 'hydra-android-sources/body))

(defun zbasic-my/init-org-alert ()
  (use-package
    org-alert
    :ensure t
    :config (progn (org-alert-enable)
                   (setq alert-default-style 'libnotify))))
(defun zbasic-my/init-wordnut ()
  (use-package
    wordnut
    :defer t
    :commands (wordnut-search wordnut-lookup-current-word)
    :init (progn (if (equal 0 (call-process "which" nil '("*Shell Command Output*" t) nil
                                            "wordnet")) nil (progn (message "installing wordnet...")
                                                                   (if (equal 0 (call-process "sudo"
                                                                                              nil
                                                                                              '("*Shell
 Command Output*" t) nil "apt-get" "-y" "install" "wordnet"))
                                                                       (progn (message
                                                                               "wordnet installed successfully!")
                                                                              (shell-command
                                                                               "rm /tmp/impossible-flag-name"))
                                                                     (progn
                                                                       (error
                                                                        "wordnet installation : `%s'"
                                                                        "ERROR")
                                                                       (shell-command
                                                                        "touch /tmp/impossible-flag-name"))))))
    :config (if (equal 0 (call-process "ls" nil '("*Shell
 Command Output*" t) nil "/tmp/impossible-flag-name"))
                (defun wordnut-search ()
                  (interactive)
                  (error
                   "please install `%s' package or run emacs with sudo"
                   "wordnet"))
              (message "configured wordnut"))))

(defun zbasic-my/init-dictionary ()
  (use-package
    dictionary
    :defer t
    :commands (dictionary-search)))
(defun zbasic-my/init-helm-rg ()
  (use-package
    dictionary
    :defer t
    :commands (helm-rg)))
(defun zbasic-my/pre-init-engine-mode ()
(spacemacs|use-package-add-hook engine-mode
    :pre-init
    ;; Code
    (setq search-engine-config-list '((emacs-stack-exchange :name "emacs stack exchange"
                                                          :url "https://emacs.stackexchange.com/search?q=%s")))
    ))
