;; Make new window for listing of buffers
(global-set-key (kbd "C-x C-b") 'buffer-menu-other-window)

;; Make C-x C-o choose other window and make it full screem
(defun select-other-full ()
  (interactive)
  (other-window 1)
  (delete-other-windows))

(global-set-key (kbd "C-x C-o") 'select-other-full)
