(defun eshell-copy-last-command-output ()
  (interactive)
  (save-excursion (eshell-mark-output 1)
                  (kill-ring-save (point-min)
                                  (point-max))
                  (widen))
  (unwind-protect (kill-buffer "*last_eshell_command*")
    (let ((buffer (get-buffer-create "*last_eshell_command*")))
      (message "here")
      (with-current-buffer buffer (erase-buffer)
                           (goto-char (point-min))
                           (yank)
                           (compilation-mode))
      (switch-to-buffer buffer))))

(defvar notes-org-dir  "/home/sysmanj/Documents/code/tasking/notes-org/")
(defun export-notes-to-html ()
  (interactive)
  (message (format "%s" load-path))
  (add-to-list 'load-path "/home/sysmanj/.emacs.d/elpa/26.1/develop/htmlize-20180923.1829/")
  (require 'ox-html)
  (require 'htmlize)
  (setq org-publish-project-alist `(

                                    ;; ... add all the components here (see below)...
                                    ("org-notes" :base-directory ,notes-org-dir
                                     :base-extension "org"
                                     :publishing-directory
                                     "/home/sysmanj/Documents/code/tasking/notes-html"
                                     :recursive t
                                     :publishing-function org-html-publish-to-html
                                     :headline-levels 4 ; Just the default for this project.
                                     :auto-preamble t)))

  (org-notes-sync-dependencies)
  (org-publish "org-notes" t))

(defun org-notes-sync-dependencies ()
  (interactive)
  (let ((cp-template "cp %s %s%s" ))
    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+lang/latex/README.org"
                           notes-org-dir "latexREADME.org") nil nil)
    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+lang/java/README.org"
                           notes-org-dir "../nopub/javaREADME.org") nil nil)
    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+lang/c-c++/README.org"
                           notes-org-dir "cppReadm.org") nil nil)
    (shell-command (format cp-template "/home/sysmanj/Documents/soft/rtags-2.33/README.org"
                           notes-org-dir "rtagsREADME.org") nil nil)

    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+source-control/git/README.org"
                           notes-org-dir "../nopub/gitREADME.org") nil nil)
    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+source-control/version-control/README.org"
                           notes-org-dir "verconREADME.org") nil nil)
    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+spacemacs/spacemacs-purpose/README.org"
                           notes-org-dir "purposemodeREADME.org") nil nil)
    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+tools/lsp/README.org"
                           notes-org-dir "lspREADME.org") nil nil)
    (shell-command (format cp-template "/home/sysmanj/.emacs.d/layers/+tags/gtags/README.org"
                           notes-org-dir "gtagsREADME.org") nil nil)
    ))

(defun periodic-refresh-lsp-kotlin ()
  (run-with-timer 20 60 '(lambda ()
                           (when (equal major-mode 'kotlin-mode)
                             (lsp-restart-workspace)))))

(defun my-insert-tab-char ()
  (interactive)
  (insert "\t"))

(defun clean-hightlight-regexp-all ()
  (interactive)
  (unhighlight-regexp t))

(defun switch-to-eshell ()
  (interactive)
  (switch-to-buffer "*eshell*"))

(defun extract-last-search ()
  (if isearch-regexp (progn
                       ;; (message ( format "extracted %s" (car-safe regexp-search-ring)))
                       (car-safe regexp-search-ring))
    (progn
      ;; (message ( format "extracted %s"(regexp-quote (car-safe search-ring))))
      (regexp-quote (car-safe search-ring)))))

(defun rep-isearch-forward ()
  (interactive)
  (let ((my-search (extract-last-search)))
    (isearch-forward isearch-regexp t)
    ;; (let ((isearch-regexp  nil))
    ;;   (isearch-yank-string my-search))
    (isearch-repeat-forward)
    (if (< (length my-search) ace-isearch-input-length)
        (run-with-timer 0.1 nil 'ace-isearch-jump-during-isearch-helm-swoop))))

(defun rep-isearch-backward ()
  (interactive)
  (let ((my-search (extract-last-search)))
    (isearch-backward isearch-regexp t)
    ;; (let ((isearch-regexp  nil))
    ;;   (isearch-yank-string my-search))
    (isearch-repeat-backward)
    (if (< (length my-search) ace-isearch-input-length)
        (run-with-timer 0.05 nil 'ace-isearch-jump-during-isearch-helm-swoop))))


(defun ace-jump-last-search ()
  (let ((ace-jump-mode-scope 'global))
    ;; (message "wTFFFF? started")
    (ace-jump-do (extract-last-search))))

(defun avy-jump-last-search ()
  (let ((avy-all-windows nil))
    ;; (message "wTFFFF? started alternative")
    (avy-isearch)))

;;kinda of an override))
(defun ace-isearch-jump-during-isearch-helm-swoop ()
  "Jump to the one of the current isearch candidates."
  (interactive)
  (if (< (length isearch-string) ace-isearch-input-length)
      (cond ((eq ace-isearch--ace-jump-or-avy 'ace-jump)
             (progn (isearch-exit)
                    (evil-scroll-line-to-center nil)
                    (run-with-timer 0.05 nil 'ace-jump-last-search)))
            ((eq ace-isearch--ace-jump-or-avy 'avy)
             (let ((avy-all-windows nil))
               (avy-isearch))))
    (cond ((eq ace-isearch--ace-jump-or-avy 'ace-jump)
           (progn
             ;; (message "wTFFFF? init")
             ;; (message (format "swoop: %s" helm-swoop-pattern))
             (run-with-timer 0.05 nil 'ace-jump-last-search)
             (helm-exit-minibuffer))))
    ((eq ace-isearch--ace-jump-or-avy 'avy)
     (progn
       ;; (message (format "swoop: %s" helm-swoop-pattern))
       (run-with-timer 0.05 nil 'avy-jump-last-search)
       (helm-exit-minibuffer)))))


;;kinda of an override))
(defun helm-swoop-from-isearch-override ()
  "Invoke `helm-swoop' from isearch."
  (interactive)
  (let (($query isearch-string))
    (let (search-nonincremental-instead)
      (isearch-exit))
    (helm-swoop :$query $query)))

(defun evil-next-respect-isearch ()
  (interactive)
  (setq evil-regexp-search isearch-regexp)
  (evil-search-next))
(defun evil-previous-respect-isearch ()
  (interactive)
  (setq evil-regexp-search isearch-regexp)
  (evil-search-previous))

(advice-add 'evil-visualstar/begin-search-forward
            :before '(lambda (beg end)
                       (push
                        (buffer-substring-no-properties
                         beg
                         end)
                        search-ring)))

(advice-add 'evil-visualstar/begin-search-backward
            :before '(lambda (beg end)
                       (push
                        (buffer-substring-no-properties
                         beg
                         end)
                        search-ring)))

(defun describe-variable-and-kill-value (variable)
  (interactive "SValues:")
  (let ((res (symbol-value variable) ))
    (kill-new (if res res "NONE"))))

(defun goto-delimiter-forward ()
  (interactive)
  (forward-char 1)
  (while (not (equal (char-syntax (char-after)) ?\)))
    (forward-char 1)))


(defun goto-delimiter-backward-stop ()
  (interactive)
  (goto-delimiter-backward nil))

(defun goto-delimiter-backward
    (&optional
     inter)
  (interactive "p")
  ;; (message (format "%s" inter))
  (forward-char -1)
  (while (not (equal (char-syntax (char-after)) ?\())
    (forward-char -1))
  (if inter nil (forward-char 1)))

(defun keymap-symbol (keymap)
  "Return the symbol to which KEYMAP is bound, or nil if no such symbol exists."
  (catch 'gotit
    (mapatoms (lambda (sym)
                (and (boundp sym)
                     (eq (symbol-value sym) keymap)
                     (not (eq sym 'keymap))
                     (throw 'gotit sym))))))

(defun custom-layout1 ()
  (interactive)
  ;; (if (gnus-buffer-exists-p "*spacemacs*")
  ;;     (kill-buffer "*spacemacs*"))
  (switch-to-buffer "*spacemacs*")
  (purpose-load-window-layout-file
   "/home/sysmanj/Documents/.spacemacs/private/zbasic-my/layouts/MyFavIDE.window-layout")
  (winum-select-window-3))

(defun custom-layout2 ()
  (interactive)
  ;; (if (gnus-buffer-exists-p "*spacemacs*")
  ;;     (kill-buffer "*spacemacs*"))
  (switch-to-buffer "*spacemacs*")
  (purpose-load-window-layout-file
   "/home/sysmanj/Documents/.spacemacs/private/zbasic-my/layouts/MyFavIDE2.window-layout")
  (winum-select-window-3))

(defun clone-kotlin-skeleton
    (&optional
     loc)
  (interactive "DProject name:")
  (message (format "mes: %s" loc))
  (let ((command  "/home/sysmanj/Documents/.spacemacs/private/zbasic-my/template.sh %s")
        (dir (if (equal loc "/") "." loc)))
    (shell-command (format command dir))))

(defun flymake-goto-purposed-window()
  (interactive)
  (flymake-show-diagnostics-buffer)
  (run-with-timer 0.1 nil '(lambda ()
                             (let* ((flym-buffer (flymake--diagnostics-buffer-name))
                                    (cand-window (get-buffer-window flym-buffer)))
                               (if (and cand-window
                                        (not (window-parameter cand-window 'purpose-dedicated)))
                                   (progn (delete-window cand-window))))
                             (switch-to-buffer (flymake--diagnostics-buffer-name)))))

(defmacro add-jump-push-action (command-symbol)
  `(advice-add ,command-symbol
               :before '(lambda
                          (&rest
                           args)
                          "unexpected jump push evil" (evil-set-jump))))

(defun kotlin-syntax-highlight ()
  (set (make-local-variable 'font-lock-defaults)
       '(kotlin-mode--font-lock-keywords nil nil nil nil)))
