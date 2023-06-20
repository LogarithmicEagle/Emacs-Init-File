;; Make other buffer selected
(global-set-key "\C-x\C-b" 'buffer-menu-other-window)

;; Make C-x C-o choose other window and make it full screem
(defun select-other-full ()
  (interactive)
  (other-window 1)
  (delete-other-windows))

(global-set-key (kbd "C-x C-o") 'select-other-full)

;; smex
;(global-set-key (kbd "M-x") 'smex)
;(global-set-key (kbd "M-x") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Put copy as C-w
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "M-w") 'kill-region)

;; Swap a and enter in dired
(eval-after-load "dired"
  '(progn    
     (define-key dired-mode-map (kbd "<RET>") 'dired-find-alternate-file)
     (define-key dired-mode-map "a" 'dired-find-file)))

;; Spell correct right click
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [mouse-3] 'flyspell-correct-word)))

;; Hyperspace
(global-set-key (kbd "C-c C-h") 'hyperspace)

;; Make eval sexp pretty print
(global-set-key (kbd "C-x C-e") 'pp-eval-last-sexp)

;; Avy
(global-set-key (kbd "M-j") 'avy-goto-char)
(global-set-key (kbd "C-M-j") 'avy-goto-char-2)

;; Make button combos pressable in terminal
(global-set-key (kdb "C-x a") 'set-mark-command)
