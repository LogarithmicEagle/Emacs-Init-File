;; Timestamp 2023-01-27

(setq package-enable-at-startup nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(conda-anaconda-home "c:/Users/zacha/Anaconda3")
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults)))
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(initial-buffer-choice t)
 '(initial-scratch-message
   ";; This buffer is for text that is not saved, and for Lisp evaluation.
;; Eval is C-j

")
 '(org-agenda-files (quote ("d:/Documents/School/todo.org")))
 '(org-fontify-done-headline nil)
 '(org-fontify-todo-headline nil)
 '(package-selected-packages
   (quote
    (avy realgud blacken flycheck-pycheckers elpy all-the-icons centaur-tabs zeal-at-point wolfram-mode wolfram undo-tree spacemacs-theme smex slime slack scihub python-info org-superstar org-drill org-d20 org-books monochrome-theme maxima math-symbols latex-preview-pane langtool hyperspace highlight haskell-mode grammarly free-keys flycheck emms-state elscreen conda company-math chess cdlatex auctex ac-math ac-ispell)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Tell Emacs that I'm not a dummy
(setq disabled-command-function nil)
;; Load Files
(ignore-errors
  (progn
    (load "~/.emacs.d/key-bind.el") ;; Key Bindings
    (load "~/.emacs.d/hyperspace-commands.el"))) ;; Hyperspace Commands

;; Enable recursive mini-buffers
(setq enable-recursive-minibuffers t)

;; Auto open mode based on file type
;(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

;; Turn off Beeps
(setq visible-bell t)

;; Line Wraping
(global-visual-line-mode t)

;; Package Stuff

;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; IDO Mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Prevent lag from math-symbols
(setq inhibit-compacting-font-caches t)

;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-x") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Tabs
(centaur-tabs-mode t)
(setq centaur-tabs-set-icons t)

;; Flyspell
(setq-default ispell-program-name "D:/Program Files/MSYS2/mingw64/bin/aspell.exe")
(add-hook 'outline-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode);; Add auto autocorrect to text docs

;; LangTool
(setq langtool-language-tool-jar "~/emacs/LanguageTool-5.2/LanguageTool-5.2/languagetool-commandline.jar") ;; Shows where LangTool is installed

(defun langtool-autoshow-detail-popup (overlays) ;; Make LangTool Pop-up
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))
(setq langtool-autoshow-message-function
      'langtool-autoshow-detail-popup)

;(define-key org-mode-map (kbd "C-$") 'langtool-check)
;(define-key org-mode-map (kbd "M-4") 'langtool-correct-buffer)
;(define-key org-mode-map (kbd "C-M-4") 'langtool-check-done) ;; Key-bind LangTool

;; SBCL + Slime
;(load "~/quicklisp/slime-helper.el")
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;; Python mode add conda - DOES NOT START ON START-UP
(defun setup-python-init ()
  (elpy-enable)
  (local-set-key (kbd "C-c C-.") 'execute-extended-command))
  
(add-hook 'python-mode-hook 'setup-python-init)

;; CDLateX
(setq cdlatex-command-alist
      '(("lim" "Insert Lim" "\\lim_{?}" cdlatex-position-cursor nil nil t)
	("ti" "Insert \\to\\infty" "\\to\\infty" nil nil nil t)
	("t0" "Insert \\to0" "\\to0" nil nil nil t)
	("=" "Insert a &= for align or align*" "&=" nil nil nil t)
	("dv" "Insert a derrivative" "\\frac{d}{d ?}" cdlatex-position-cursor nil nil t)
	("dx" "Insert a derrivative with respect to x" "\\frac{d}{dx}" nil nil nil t)
	("pd" "Insert a partial derivative" "\\frac{\\partial}{\\partial ?}" cdlatex-position-cursor nil nil t)
	("sum" "Insert a sum with a subscript" "\\sum_{?}" cdlatex-position-cursor nil nil t)
	("mat" "Insert plain matrix (matrix) env"   "" cdlatex-environment ("matrix") t t)
	("bmat" "Insert square bracket matrix(bmatrix) env"   "" cdlatex-environment ("bmatrix") t t)
	("pmat" "Insert parenth bracket matrix (pmatrix) env"   "" cdlatex-environment ("pmatrix") t t)
	("m" "Make math environment inline" "$?$" cdlatex-position-cursor nil t t)));; Add custom templates to CDLaTeX
(setq cdlatex-math-modify-alist
      '((?d "\\mathbb" nil t nil nil))) ;; Add custom modifiers to CDLaTeX
(setq cdlatex-math-symbol-alist
      '((?< ("\\leq" "\\leftarrow" "\\longleftarrow"))
	(?> ("\\geq" "\\rightarrow" "\\longrightarrow"))
	(?= ("\\neq" "\\Leftrightarrow" "\\Longleftrightarrow"))
	(?t ("\\tau" "\\times" "\\tan"))
	(?. ("\\ldots" "\\cdot")))) ;; Add custom symbols to CDLaTeX
(add-hook 'org-mode-hook 'turn-on-org-cdlatex) ;; Turn on CDLaTeX

;; Org mode
(defun setup-org ()
  (setq org-capture-templates
	'(("n" "Quote" entry (file "~/emacs/Capture/Quote.org")
	   "* %u\n\"%i\"\n\t- %^{Speaker}, %^{Source}\n" :prepend t :kill-buffer t :empty-lines 1))) ;; Org capture templates
  (org-babel-do-load-languages 'org-babel-load-languages
			       '((emacs-lisp t)
				 (python t)
				 (C t)
				 (calc t)
				 (eshell t)
				 (gnuplot t)
				 (latex t)
				 (java t)
				 (lisp t)
				 (octave t)
				 )) ;; Allows for code execution in org mode files
  (setq org-confirm-babel-evaluate nil) ;; Disables security confirm to run code blocks in org mode
  (org-superstar-mode 1)) ;; Fancy Bullets
(add-hook 'org-mode-hook 'setup-org)
