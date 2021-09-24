;; Timestamp 24-9-2021

(setq package-enable-at-startup nil)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "c:/Users/zacha/Anaconda3")
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(initial-buffer-choice t)
 '(initial-scratch-message
   ";; This buffer is for text that is not saved, and for Lisp evaluation.
;; Eval is C-j

")
 '(org-agenda-files (quote ("d:/Documents/School/todo.org")))
 '(package-selected-packages
   (quote
    (undo-tree org-superstar free-keys langtool latex-preview-pane cl-lib auctex cdlatex emms-state emms highlight conda elscreen spacemacs-theme maxima haskell-mode zeal-at-point python-info org-d20 org-books org-drill hyperspace company-math company ac-ispell slack math-symbols wolfram-mode ac-math auto-complete smex))))
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

;; Flyspell
(setq-default ispell-program-name "D:/Program Files/MSYS2/mingw64/bin/aspell.exe")
(add-hook 'outline-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode);; Add auto autocorrect to text docs

;; LangTool
(setq langtool-language-tool-jar "~/emacs/LanguageTool-5.2/LanguageTool-5.2/languagetool-commandline.jar") ;; Shows where LangTool is installed
(require 'langtool)

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

(require 'org)
(define-key org-mode-map (kbd "C-$") 'langtool-check)
(define-key org-mode-map (kbd "M-4") 'langtool-correct-buffer)
(define-key org-mode-map (kbd "C-M-4") 'langtool-check-done) ;; Key-bind LangTool

;; CLISP
(setq inferior-lisp-program "sbcl")

;; Slime
;; This doesn't work now, and I'm tired of trying to get this to work
;; I'll leave the code in for future me
;;(add-to-list 'load-path "d:/Documents/Programming/LISP/lispstick/lispstick/slime-2013-12-18")
;;(require 'slime)

;; Python mode add conda - DOES NOT START ON START-UP
(defun setup-conda ()
  (require 'conda)
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode t)
  (custom-set-variables
    '(conda-anaconda-home "c:/Users/zacha/Anaconda3"))
  (setq conda-env-home-directory (expand-file-name "c:/Users/zacha/Anaconda3"))
  (conda-env-activate "base"))
;; (add-hook 'python-mode-hook 'setup-conda)

;; CDLateX
(setq cdlatex-command-alist
      '(("lim" "Insert Lim" "\\lim_{?}" cdlatex-position-cursor nil nil t)
	("ti" "Insert \\to\\infty" "\\to\\infty" nil nil nil t)
	("t0" "Insert \\to0" "\\to0" nil nil nil t)
	("=" "Insert a &= for align or align*" "&=" nil nil nil t)
	("dv" "Insert a derrivative" "\\frac{d}{d ?}" cdlatex-position-cursor nil nil t)
	("dx" "Insert a derrivative with respect to x" "\\frac{d}{dx}" nil nil nil t)
	("pd" "Insert a partial derivative" "\\frac{\\partial}{\\partial ?}" cdlatex-position-cursor nil nil t)
	("sum" "Insert a sum with a subscript" "\\sum_{?}" cdlatex-position-cursor nil nil t)));; Add custom templates to CDLaTeX
(setq cdlatex-math-modify-alist
      '((?d "\\mathbb" nil t nil nil))) ;; Add custom modifiers to CDLaTeX
(setq cdlatex-math-symbol-alist
      '((?< ("\\leq" "\\leftarrow" "\\longleftarrow"))
	(?> ("\\geq" "\\rightarrow" "\\longrightarrow"))
	(?= ("\\neq" "\\Leftrightarrow" "\\Longleftrightarrow"))
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
