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

(defun buffer-nx ()
  (interactive)
  (insert buffer-file-name))

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

(defun highlight-visual-regexp ()
  (interactive)
  (let ((substring (buffer-substring-no-properties (region-beginning)
                                                   (region-end) )))
    (setq search-ring (cons substring
                            search-ring))
    (highlight-regexp substring (nth highlight-regex-faces-ind highlight-regex-faces))
    (setq highlight-regex-faces-ind (% (+ 1 highlight-regex-faces-ind) highlight-regex-faces-num)))
  )

(defun clean-hightlight-regexp-all ()
  (interactive)
  (unhighlight-regexp t))

(defun clone-c-skeleton
    (&optional
     loc)
  (interactive "DProject name:")
  (message (format "cloning c-skeleton to: %s" loc))
  (let ((command  "/home/hypen9/Documents/.spacemacs/private/my-basic/templateC.sh %s")
        (dir (if (equal loc "/") "." loc)))
    (shell-command (format command dir))))

(defun create-checkpoint (mess)
  "docstring"
  (interactive "SMessage of checkpoint:")
  (shell-command (format  "git add -A && git commit -m '%s'" mess)))

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

(defun contains-searched-key (keymap symbol chars--list result--list)
  (if (> (seq-length chars--list) 1)
      (progn (map-keymap '(lambda (event def)
                            (if (equal event (car chars--list))
                                (progn(message (format "%d recur" event))
                                      (if (keymapp def)(contains-searched-key def symbol (cdr chars--list) result--list))

                                      ;;
                                      ))) keymap))
    (progn (map-keymap '(lambda (event def)
                          (if (equal event (car chars--list))
                              (progn(message (format "keymap: {%s} event:[%d] found def:[%s]" symbol event def))
                                    (set result--list (cons (cons symbol def)(eval result--list)))

                                    ;;
                                    ))) keymap))))

(defun collect-containing-keymaps (char-seqence result--list)
  "(collect-containing-keymaps (kbd \"SPC s t p\") 'resultl)"
  (let ((chars--list (string-to-list char-seqence)))
    (dolist (sym chars--list)
      (message (format "char %d " sym )))
    (mapatoms (lambda (sym)
                (and (boundp sym)
                     (keymapp (symbol-value sym))
                     (contains-searched-key (symbol-value sym) sym chars--list result--list))))
    )
  )
(defun custom-layout1 ()
  (interactive)
  (purpose-load-window-layout-file
   "/home/hypen9/Documents/.spacemacs/private/my-basic/layouts/MyFavIDE.window-layout")
  (message "MyFavIDE layout loaded")
  (winum-select-window-2))

(defun custom-layout2 ()
  (interactive)
  (purpose-load-window-layout-file
   "/home/hypen9/Documents/.spacemacs/private/my-basic/layouts/MyFavIDE2.window-layout")
  (message "MyFavIDE2 layout loaded")
  (winum-select-window-2))

(defun custom-layout-eww ()
  (interactive)
  (purpose-load-window-layout-file
   "/home/hypen9/Documents/.spacemacs/private/my-basic/layouts/eww.window-layout")
  (message "eww layout loaded")
  (winum-select-window-1))

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

(defun kill-buffers-by-major-mode (mode-symbol)
  (interactive)
  (mapc (lambda (buffer)
          (when (eq mode-symbol (buffer-local-value 'major-mode buffer))
            (message (format "killing buffer %s" buffer))
            (kill-buffer buffer)))
        (buffer-list))
  t)

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

(defun toggle-window-dedicated ()
  "Control whether or not Emacs is allowed to display another
buffer in current window."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "%s: Can't touch this!"
     "%s is up for grabs.")
   (current-buffer)))

;;https://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(spacemacs|add-toggle toggle-window-dedicatedness
  :status (window-dedicated-p (get-buffer-window (current-buffer)))
  :on (toggle-window-dedicated)
  :off (toggle-window-dedicated)
  :documentation "toggle current window being dedicated to a buffer"
  :on-message "toggled window dedicatedness to buffer ON"
  :off-message "toggled window dedicatedness to buffer OFF"
  :evil-leader "t%")


(spacemacs|add-toggle toggle-imenu-list-position
  :status (eq imenu-list-position 'left)
  :on (setq imenu-list-position 'left)
  :off (setq imenu-list-position 'right)
  :documentation "toggle imenu-list position right/left"
  :on-message "oggled imenu-list buffer LEFT"
  :off-message "toggled imenu-list buffer RIGHT"
  :evil-leader "tq")

(spacemacs|add-toggle toggle-evil-matchit
  :status evil-matchit-mode
  :on (evil-matchit-mode 1)
  :off (evil-matchit-mode -1)
  :documentation "toggle evil matchit mode"
  :on-message "toggle evil matchit mode ON"
  :off-message "toggle evil matchit mode OFF"
  :evil-leader "t5")

(spacemacs|add-toggle eww-or-external-browser
  :status (equal browse-url-browser-function 'eww-browse-url)
  :on (toggle-browse-eww-system-browser 1)
  :off (toggle-browse-eww-system-browser -1)
  :documentation "toggled EWW or external for browser related tasks"
  :on-message "toggled EWW for browser related tasks"
  :off-message "toggled FIREFOXISH for browser related tasks"
  :evil-leader "t?")

(spacemacs|add-toggle purpose-mode-toggle
  :status purpose-mode
  :on (purpose-mode 1)
  :off (purpose-mode -1)
  :documentation "toggle purpose mode"
  :on-message "toggled purpose-mode ON"
  :off-message "toggled purpose-mode OFF"
  :evil-leader "tx")

(spacemacs|add-toggle evil-search-highlight-persist
  :status global-evil-search-highlight-persist
  :on (global-evil-search-highlight-persist 1)
  :off (global-evil-search-highlight-persist -1)
  :documentation "toggle evil search highlight persist"
  :on-message "toggled evil search highlight persist ON"
  :off-message "toggled evil search highlight persist OFF"
  :evil-leader "t,")

(spacemacs|add-toggle company-toggle-auto-popup
  :status (< company-minimum-prefix-length 10)
  :on (progn (setq company-minimum-prefix-length 2)
             (setq company-auto-complete-chars (list 32 41 46)))
  :off (progn
         (setq company-minimum-prefix-length 1000)
         (setq company-auto-complete-chars (list)))
  :documentation "toggle auto pop up of company completion list"
  :on-message "toggle comapany completion list ON"
  :off-message "toggle comapany completion list OFF"
  :evil-leader "t0")


(defun toggle-imenu-index-func ()
  "toggle imenu index function"
  (interactive )
  (if (eq imenu-create-index-function 'imenu-default-create-index-function)

      (progn (message (format "set %s to %s" "imenu-create-index-function" "ggtags-build-imenu-index"))
             (setq imenu-create-index-function #'ggtags-build-imenu-index))
    (progn (message (format "set %s to %s" "imenu-create-index-function" "imenu-default-create-index-function"))
           (setq imenu-create-index-function #'imenu-default-create-index-function)))
  )
