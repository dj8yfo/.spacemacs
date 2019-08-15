;;; packages.el --- my-sengines-dicts layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Gis Ochre <gisochrewhb@gmail.com>
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
;; added to `my-sengines-dicts-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-sengines-dicts/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-sengines-dicts/pre-init-PACKAGE' and/or
;;   `my-sengines-dicts/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-sengines-dicts-packages
  '(helm-dash wordnut dictionary engine-mode)
  "The list of Lisp packages required by the my-sengines-dicts layer.

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
(defun my-sengines-dicts/init-helm-dash ()
  (use-package
    helm-dash
    :commands (helm-dash helm-dash-at-point)
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

(defun my-sengines-dicts/init-wordnut ()
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

(defun my-sengines-dicts/init-dictionary ()
  (use-package
    dictionary
    :defer t
    :commands (dictionary-search)
    :config
    (set-face-font 'dictionary-word-definition-face
                   "-xos4-Terminess Powerline-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1"))
  )

(defun my-sengines-dicts/pre-init-engine-mode ()
  (spacemacs|use-package-add-hook engine-mode
    :pre-init
    ;; Code
    (setq search-engine-config-list '((emacs-stack-exchange :name "emacs stack exchange"
                                                            :url
                                                            "https://emacs.stackexchange.com/search?q=%s")))))
