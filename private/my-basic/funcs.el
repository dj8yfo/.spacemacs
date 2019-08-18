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


(defun my-insert-tab-char ()
  (interactive)
  (insert "\t"))

(defun switch-to-eshell ()
  (interactive)
  (switch-to-buffer "*eshell*"))

;;kinda of an override))

(defun describe-variable-and-kill-value (variable)
  (interactive "SValues:")
  (let ((res (symbol-value variable) ))
    (kill-new (if res res "NONE"))))

(defun kill-backward-until-sep ()
  (interactive)
  (while (not (equal (point)
                     (buffer-end 1)))
    (delete-char 1))
  (delete-char -1)
  (while (not (equal ?/ (char-before)))
    (delete-char -1)))

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
  (purpose-load-window-layout-file
   "/home/sysmanj/Documents/.spacemacs/private/my-basic/layouts/MyFavIDE.window-layout")
  (winum-select-window-3))

(defun custom-layout2 ()
  (interactive)
  (purpose-load-window-layout-file
   "/home/sysmanj/Documents/.spacemacs/private/my-basic/layouts/MyFavIDE2.window-layout")
  (winum-select-window-3))

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

(defun split-visual-region (&optional separator)
  (interactive "sSeparator")
  (if (equal separator "") (setq separator nil))
  (let ((result (split-string (buffer-substring-no-properties (region-beginning)
                                                              (region-end) ) separator)))
    (delete-region (region-beginning) (region-end))
    (dolist (elem result nil)
      (insert elem)
      (insert "\n"))
    )
  )

(defmacro add-jump-push-action (command-symbol)
  `(advice-add ,command-symbol
               :before '(lambda
                          (&rest
                           args)
                          "unexpected jump push evil" (evil-set-jump))))
(defun kill-eww-buffers ()
  (interactive)
  (kill-matching-buffers ".*eww.*" t t))

(defun toggle-browse-eww-system-browser
    (&optional
     arg)
  (interactive "P")
  (if (or (and arg
               (> arg 0))
          (equal browse-url-browser-function 'browse-url-default-browser))
      (progn (message "setting helm-dash browser to EWW")
             (setq helm-dash-browser-func 'eww)
             (message "setting engine/browser-function to EWW")
             (setq engine/browser-function 'eww-browse-url)
             (message "setting browse-url-browser-function to EWW")
             (setq browse-url-browser-function 'eww-browse-url))
    (progn (message "setting helm-dash browser to BROWSER")
           (setq helm-dash-browser-func 'browse-url)
           (message "setting engine/browser-function to BROWSER")
           (setq engine/browser-function 'browse-url-default-browser)
           (message "setting browse-url-browser-function to BROWSER")
           (setq browse-url-browser-function 'browse-url-default-browser))))

(spacemacs|add-toggle eww-or-external-browser
  :status (equal browse-url-browser-function 'eww-browse-url)
  :on (toggle-browse-eww-system-browser 1)
  :off (toggle-browse-eww-system-browser -1)
  :documentation "toggled EWW or external for browser related tasks"
  :on-message "toggled EWW for browser related tasks"
  :off-message "toggled FIREFOXISH for browser related tasks"
  :evil-leader "t?")
