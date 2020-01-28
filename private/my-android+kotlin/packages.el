;;; packages.el --- my-android+kotlin layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Fux Tocy <you_use_gmail_feel_retarded@gmail.com>
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
;; added to `my-android+kotlin-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-android+kotlin/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-android+kotlin/pre-init-PACKAGE' and/or
;;   `my-android+kotlin/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-android+kotlin-packages '(android-env)
  "The list of Lisp packages required by the my-android+kotlin layer.

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
(defun my-android+kotlin/init-android-env ()
  (use-package
    android-env
    :defer t
    :commands (hydra-android/body)
    :after hydra
    :bind (("C-c a" . hydra-android/body))
    :config (defvar hydra-android nil)
    (setq android-env-executable "./gradlew")
    (setq android-env-test-command "connectedDevDebugAndroidTest")
    (setq android-env-unit-test-command "testDevDebug")
    (android-env)))

(defun my-android+kotlin/post-init-android-env ()
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
("/" nil "quit")
("q" nil "quit"))))
  )

