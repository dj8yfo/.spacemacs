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

(with-eval-after-load 'hydra
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
("q" nil "quit")))


(defun periodic-refresh-lsp-kotlin ()
  (run-with-timer 20 60 '(lambda ()
                           (when (equal major-mode 'kotlin-mode)
                             (lsp-restart-workspace)))))
(defun clone-kotlin-skeleton
    (&optional
     loc)
  (interactive "DProject name:")
  (message (format "mes: %s" loc))
  (let ((command  "/home/sysmanj/Documents/.spacemacs/private/my-basic/template.sh %s")
        (dir (if (equal loc "/") "." loc)))
    (shell-command (format command dir))))

