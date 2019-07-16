(defun eshell-copy-last-command-output ()
  (interactive)
  (save-excursion
    (eshell-mark-output 1)
    (kill-ring-save (point-min) (point-max))
    (widen)
    )
  (unwind-protect
      (kill-buffer "*last_eshell_command*")
    (let ((buffer (get-buffer-create "*last_eshell_command*")))
      (switch-to-buffer-other-window buffer)
      ;; (set-buffer buffer)
      (erase-buffer)
      (goto-char (point-min))
      (yank)
      (compilation-mode)
      ))
  )

(defun export-notes-to-html ()
  (interactive)
  (find-file "~/NOTES.org")
  (org-html-export-as-html)
  (write-file "~/NOTES.html")
  (write-file "/home/sysmanj/Documents/code/tasking/NOTES.html")
  )

(defun periodic-refresh-lsp-kotlin ()
  (run-with-timer 20 60 '(lambda ()
                           (when (equal major-mode 'kotlin-mode)
                             (lsp-restart-workspace))
                           )
                  )
  )

(defun my-insert-tab-char ()
  (interactive)
  (insert "\t"))

(defun clean-hightlight-regexp-all ()
  (interactive)
  (unhighlight-regexp t))

(defun switch-to-eshell ()
  (interactive)
  (switch-to-buffer "*eshell*"))