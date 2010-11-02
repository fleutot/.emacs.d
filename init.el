; directory to put various el files into
(add-to-list 'load-path "includes")

(setq auto-mode-alist (cons '(".ss$" . asm-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".inc$" . asm-mode) auto-mode-alist))

; loads ruby mode when a .rb file is opened.
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))

(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
            (define-key ruby-mode-map "\C-m" 'newline-and-indent) ;Not sure if this line is 100% right but it works!
            (require 'ruby-electric)
            (ruby-electric-mode t)
            ))

; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

(global-set-key "\C-c\C-c" 'compile)

;; Deactivate closing all with C-x C-c, replace with M-<f4>.
(global-set-key "\C-x\C-c" 'null)
(global-set-key (kbd "M-<f4>") 'save-buffers-kill-emacs)

(show-paren-mode 1)

; Color theme
(require 'color-theme)
(color-theme-pok-wog)
;;Emacs.pane.menubar.* does not seem to work? 
;Emacs.pane.menubar.background: darkGrey
;Emacs.pane.menubar.foreground: black


; Default font 9 pt
(set-face-attribute 'default nil :height 80)

(defun my-compilation-mode-hook ()
  (setq truncate-lines t)
  ;(setq truncate-partial-width-windows nil)
)
(add-hook 'compilation-mode-hook 'my-compilation-mode-hook)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(compilation-scroll-output t)
 '(egg-enable-tooltip t)
 '(egg-git-command "c:\\Program\\git\\bin\\git")
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "limegreen" :slant oblique))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :foreground "orange" :weight bold)))))


(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-tab] (lambda () (interactive) (other-window -1)))


(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux 
kernel."
  (interactive)
  (c-mode)
  (setq c-indent-level 8)
  (setq c-brace-imaginary-offset 0)
  (setq c-brace-offset -8)
  (setq c-argdecl-indent 8)
  (setq c-label-offset -8)
  (setq c-continued-statement-offset 8)
  (setq indent-tabs-mode nil)
  (setq tab-width 8))


; Warn in C for while();, if(x=0), ...
(global-cwarn-mode 1)


; no electric mode in c
(c-toggle-electric-state -1)
; indent the current line only if the cursor is at the beginning of the line
(setq-default c-tab-always-indent nil)
(setq-default c-indent-level 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default c-basic-indent 4)
(setq-default truncate-lines t)
(setq-default transient-mark-mode nil)
; These commands I read about on the web, but they don't work?
;(highlight-tabs)
;(highlight-trailing_whitespace)

(setq c-default-style "k&r")
(setq tab-width 4)
(setq indent-line-function 'insert-tab)
(setq asm-indent-level 4)



;; Remove lull: scroll bar, tool bar, menu bar.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


;; restore window size as it was at previous use
(defun restore-saved-window-size()
  (unless (load "~/.emacs.d/whsettings" t nil t)
    (setq saved-window-size '(80 30)))
  (nconc default-frame-alist `((width . ,(car saved-window-size))
                   (height . ,(cadr saved-window-size)))))

(restore-saved-window-size)

(defun save-window-size-if-changed (&optional unused)
  (let ((original-window-size  `(,(frame-width) ,(frame-height))))
    (unless (equal original-window-size saved-window-size)
      (with-temp-buffer
        (setq saved-window-size original-window-size) 
        (insert (concat "(setq saved-window-size '"
                        (prin1-to-string saved-window-size) ")"))
        (write-file "~/.emacs.d/whsettings")))))

(add-hook 'window-size-change-functions 'save-window-size-if-changed)


;; smart home behaviour
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)


;; highlight columns 78 to 80 in some modes
(require 'column-marker)

(dolist (hook '(emacs-lisp-mode-hook
                cperl-mode-hook
                shell-mode-hook
                text-mode-hook
                change-log-mode-hook
                makefile-mode-hook
                message-mode-hook
                c-mode-hook
                asm-mode-hook
                texinfo-mode-hook))
  (add-hook hook (lambda ()
                   (interactive)
                   (column-marker-1 78)
                   (column-marker-2 79)
                   (column-marker-3 80))))
(defface column-marker-1 '((t (:backgroung "red")))
  "Face for column marker 1."
  :group 'faces)
(defvar column-marker-1-face ((t (:background "PaleGreen"))))
(defvar column-marker-2-face ((t (:background "LemonChiffon"))))
(defvar column-marker-3-face ((t (:background "MistyRose")))) 


;; Ack as a replacement for grep
(global-set-key "\M-s" 'ack)
(require 'ack)
;; (add-to-list 'load-path "C:/Program/emacs-22.3/includes/full-ack")
;; (autoload 'ack-same "full-ack" nil t)
;; (autoload 'ack "full-ack" nil t)
;; (autoload 'ack-find-same-file "full-ack" nil t)
;; (autoload 'ack-find-file "full-ack" nil t)


(require 'egg)

(require 'gas-mode)

(require 'darkroom-mode)

;; Fringes are the margin areas where truncate or wrap arrows are shown.
;; Set their size here.
(set-fringe-mode '(4 . 2))

(put 'dired-find-alternate-file 'disabled nil)

