(defvar notes-org-dir  "/home/hypen9/Documents/code/tasking/notes-org/")
(defun export-notes-to-html ()
  (interactive)
  (message (format "%s" load-path))
  (add-to-list 'load-path "/home/hypen9/.emacs.d/elpa/26.3/develop/htmlize-20180923.1829")
  (require 'ox-html)
  (require 'htmlize)
  (setq org-publish-project-alist `(

                                    ;; ... add all the components here (see below)...
                                    ("org-notes" :base-directory ,notes-org-dir
                                     :base-extension "org"
                                     :publishing-directory
                                     "/home/hypen9/Documents/code/tasking/notes-html"
                                     :recursive t
                                     :publishing-function org-html-publish-to-html
                                     :headline-levels 4 ; Just the default for this project.
                                     :auto-preamble t)))
  (org-notes-sync-dependencies)
  (org-publish "org-notes" t))
(with-eval-after-load 'org
  (setq org-refile-targets '((org-agenda-files :maxlevel . 10)))
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-default-notes-file (concat notes-org-dir "notes.org"))
  (setq org-default-real-file (concat notes-org-dir "real_life.org"))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-real-file "life_kovach")
           "* TODO %?\n  %i\n  %a")
          ("j" "Journal" entry (file+headline org-default-notes-file "var info")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("c" "shell-command" entry (file+headline org-default-notes-file  "var info")
           "* %? :command \n\t#+NAME: \n\t#+BEGIN_SRC shell-script-mode\n  %i\n\t#+END_SRC\n  %a")
          ("s" "source-snippet" entry (file+headline org-default-notes-file  "var info")
           "* %? :snippet \n\t#+NAME: \n\t#+BEGIN_SRC python\n  %i\n\t#+END_SRC\n  %a")))
  )


(defun org-notes-sync-dependencies ()
  (interactive)
  (let ((cp-template "cp %s %s%s" ))
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+lang/latex/README.org"
                           notes-org-dir "latexREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+lang/java/README.org"
                           notes-org-dir "../nopub/javaREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+lang/c-c++/README.org"
                           notes-org-dir "cppReadm.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/Documents/soft/rtags-2.33/README.org"
                           notes-org-dir "rtagsREADME.org") nil nil)
    (shell-command (format cp-template
                           "/home/hypen9/.emacs.d/layers/+source-control/git/README.org"
                           notes-org-dir "../nopub/gitREADME.org") nil nil)
    (shell-command (format cp-template
                           "/home/hypen9/.emacs.d/layers/+source-control/version-control/README.org"
                           notes-org-dir "verconREADME.org") nil nil)
    (shell-command (format cp-template
                           "/home/hypen9/.emacs.d/layers/+spacemacs/spacemacs-purpose/README.org"
                           notes-org-dir "purposemodeREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+tools/lsp/README.org"
                           notes-org-dir "lspREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+tags/gtags/README.org"
                           notes-org-dir "gtagsREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+email/mu4e/README.org"
                           notes-org-dir "mu4eREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+emacs/org/README.org"
                           notes-org-dir "orgREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+tools/ranger/README.org"
                           notes-org-dir "rangerREADME.org") nil nil)
    (shell-command (format cp-template "/home/hypen9/.emacs.d/layers/+lang/python/README.org"
                           notes-org-dir "pythonREADME.org") nil nil)))

(provide 'personal-sysj-notes-exporter)
