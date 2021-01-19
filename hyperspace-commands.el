(defvar hyperspace-actions
  '(
    ;; Default
    
    ("ddg" . "https://duckduckgo.com/?q=%s")
     ("dis" . "https://duckduckgo.com/?q=%s&iax=images&ia=images")
     ("gg" . "https://www.google.com/search?q=%s")
     ("ggm" . "https://www.google.com/maps/search/%s")
     ("gis" . "https://www.google.com/search?tbm=isch&q=%s")
     ("az" . "https://www.amazon.com/s?k=%s")
     ("clp" . "https://portland.craigslist.org/search/sss?query=%s")
     ("eb" . "https://www.ebay.com/sch/i.html?_nkw=%s")
     ("alix" . "https://www.aliexpress.com/wholesale?SearchText=%s")
     ("wp" . "https://en.wikipedia.org/w/index.php?search=%s&title=Special:Search&go=Go")
     ("pg" . "https://www.gutenberg.org/ebooks/search/?query=%s")
     ("bc" . "https://bandcamp.com/search?q=%s")
     ("dgs" . "https://www.discogs.com/search/?q=%s&type=all")
     ("swi" . "https://short-wave.info/index.php?freq=%s&timbus=NOW")
     ("imdb" . "https://www.imdb.com/find?q=%s&s=all")
     ("iv" . "https://invidio.us/search?q=%s")
     ("nf" . "https://www.netflix.com/search?q=%s")
     ("yt" . "https://www.youtube.com/results?search_query=%s")
     ("dh" . "https://hub.docker.com/search?q=%s&type=image")
     ("ac" . apropos-command)
     ("af" lambda
      (query)
      (apropos-command query t))
     ("av" . apropos-variable)
     ("bb" . bbdb-search-name)
     ("el" apply-partially
      (function hyperspace-action->info)
      "(elisp)Top")

     ;; General
     ("init" . (find-file "~/.emacs.d/init.el"))
     ("pkg" . package-list-packages)
     ("tab" . elscreen-start)
     ("cap" . org-capture)

     ;; Modes
     ("morg" . org-mode)
     ("mpy" . python-mode)

     ;; Direds
     ("de" . (find-file "~/.emacs.d/"))
     ("dem" . (find-file "~/emacs/"))
     ("dd" . (find-file "d:/Documents/"))
     ("dde" . (find-file "d:/Documents/Emacs/"))
     ("dp" . (find-file "d:/Documents/Programming/"))

     ;; Themes
     ("light" . (load-theme 'spacemacs-light))
     ("dark" . (load-theme 'spacemacs-dark))

     ;; Websites
     ("w3" . "https://www.w3schools.com/%s")))
