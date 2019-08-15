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
