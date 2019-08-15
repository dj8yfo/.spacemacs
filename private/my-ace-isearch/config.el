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
