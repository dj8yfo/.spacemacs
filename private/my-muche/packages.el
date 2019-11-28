;;; packages.el --- my-muche layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: hypen9 <hypen9@hypen9-Aspire-E5-575>
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
;; added to `my-muche-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-muche/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-muche/pre-init-PACKAGE' and/or
;;   `my-muche/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-muche-packages '(mu4e)
  "The list of Lisp packages required by the my-muche layer.

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
(defun my-muche/post-init-mu4e ()
       (setq mail-user-agent 'mu4e-user-agent)
       (setq mu4e-user-agent-string nil)

       ;; default
       ;; (setq mu4e-maildir "~/Maildir")
       (setq mu4e-drafts-folder "/[Gmail].Drafts")
       (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
       (setq mu4e-trash-folder  "/[Gmail].Trash")

       ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
       (setq mu4e-sent-messages-behavior 'delete)

       ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
       ;; additional non-Gmail addresses and want assign them different
       ;; behavior.)

       ;; setup some handy shortcuts
       ;; you can quickly switch to your Inbox -- press ``ji''
       ;; then, when you want archive some messages, move them to
       ;; the 'All Mail' folder by pressing ``ma''.
       (setq mu4e-maildir-shortcuts '( ("/INBOX"               . ?i)
                                       ("/[Gmail].Sent Mail"   . ?s)
                                       ("/[Gmail].Trash"       . ?t)
                                       ("/[Gmail].All Mail"    . ?a)))

       ;; allow for updating mail using 'U' in the main view:
       (setq mu4e-get-mail-command "offlineimap")

       ;; something about ourselves
       (setq user-mail-address "gisochrewhb@gmail.com" user-full-name  "Gis Ochre"
             mu4e-compose-signature (concat "Gis Ochre"))

       ;; sending mail -- replace USERNAME with your gmail username
       ;; also, make sure the gnutls command line utils are installed
       ;; package 'gnutls-bin' in Debian/Ubuntu

       ;; (require 'smtpmail)
       ;; (setq message-send-mail-function 'smtpmail-send-it
       ;;    starttls-use-gnutls t
       ;;    smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
       ;;    smtpmail-auth-credentials
       ;;      '(("smtp.gmail.com" 587 "USERNAME@gmail.com" nil))
       ;;    smtpmail-default-smtp-server "smtp.gmail.com"
       ;;    smtpmail-smtp-server "smtp.gmail.com"
       ;;    smtpmail-smtp-service 587)

       ;; alternatively, for emacs-24 you can use:
       (setq message-send-mail-function 'smtpmail-send-it smtpmail-stream-type 'starttls
             ;; smtpmail-auth-credentials '(("smtp.gmail.com" 587 "gisochrewhb@gmail.com" nil))
             smtpmail-smtp-user "gisochrewhb" smtpmail-default-smtp-server
             "smtp.gmail.com" smtpmail-smtp-server "smtp.gmail.com" smtpmail-smtp-service 587)

       ;; don't keep message buffers around
       (setq message-kill-buffer-on-exit t))
