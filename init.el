;; Timestamp 18-1-2021

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
 '(package-selected-packages
   (quote
    (auctex cdlatex emms-state emms highlight conda elscreen spacemacs-theme maxima haskell-mode zeal-at-point python-info org-d20 org-books org-drill hyperspace company-math company ac-ispell slack math-symbols wolfram-mode ac-math auto-complete smex slime))))
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

;; Spell Check
(setq-default ispell-program-name "D:/Program Files/MSYS2/mingw64/bin/aspell.exe")
(add-hook 'text-mode-hook 'flyspell-mode) ;; Add auto autocorrect to text docs

;; Python mode add conda
(defun setup-conda ()
  (require 'conda)
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode t)
  (custom-set-variables
    '(conda-anaconda-home "c:/Users/zacha/Anaconda3"))
  (setq conda-env-home-directory (expand-file-name "c:/Users/zacha/Anaconda3"))
  (conda-env-activate "base"))
(add-hook 'python-mode-hook 'setup-conda)

;; Org Mode
(defun setup-org ()
  (setq org-capture-templates
	'(("n" "Quote" entry (file "~/emacs/Capture/Quote.org")
	   "* %u\n\"%i\"\n\t- %^{Speaker}, %^{Source}\n" :prepend t :kill-buffer t :empty-lines 1)))
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex) ;;Turn on CDLaTeX
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
  (setq org-confirm-babel-evaluate nil)) ;; Disables security confirm to run code blocks in org mode
(add-hook 'org-mode-hook 'setup-org)
