; directory to put various el files into
(add-to-list 'load-path "~/.emacs.d/includes")

; Add some extensions for assembly mode
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

;; New window pop-up vertical split threshold.
;; Windows with a fewer number of visible lines may not be split vertically.
(setq split-height-threshold 120)
(setq split-width-threshold 90)

;; Smart kill-line on end of line, strips white space from following line.
(defadvice kill-line (after kill-line-cleanup-whitespace activate compile)
      "cleanup whitespace on kill-line"
      (if (not (bolp))
	  (delete-region (point) (progn (skip-chars-forward " \t") (point)))))


; Default font 9 pt
;(set-face-attribute 'default nil :height 90)
;(set-default-font "-outline-Lucida Console-normal-normal-normal-mono-11-*-*-*-c-*-iso8859-1")
(set-default-font "Lucida Console-9")
;(set-face-attribute 'default nil :height 90)


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

; Color-coding #if 0 as comment.
(defun my-c-mode-font-lock-if0 (limit)
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))
      (let ((depth 0) str start start-depth)
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
          (setq str (match-string 1))
          (if (string= str "if")
              (progn
                (setq depth (1+ depth))
                (when (and (null start) (looking-at "\\s-+0"))
                  (setq start (match-end 0)
                        start-depth depth)))
            (when (and start (= depth start-depth))
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
              (setq start nil))
            (when (string= str "endif")
              (setq depth (1- depth)))))
        (when (and start (> depth 0))
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)

(defun my-c-mode-common-hook ()
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq-default buffer-file-coding-system 'dos)



; Color theme
(require 'color-theme)
(require 'color-theme-zenburn)
(color-theme-zenburn)
;(color-theme-pok-wog)
;;Emacs.pane.menubar.* does not seem to work? 
;(setq Emacs.pane.menubar.background 'darkGrey)
;Emacs.pane.menubar.foreground: black


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


;; Refresh on F5
;;(global-set-key (kbd "M-<f4>") 'save-buffers-kill-emacs)
(global-set-key (kbd "<f5>") '(lambda () (interactive) (revert-buffer nil t nil)))

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
(defface column-marker-1 '((t (:background "red")))
  "Face for column marker 1."
  :group 'faces)
(defvar column-marker-1-face ((t (:background "DarkGreen"))))
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


;; Better buffer list functionality.
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
  (quote (("default"      
            ("Belasigna"
              (filename . "work/bs200/"))
            ("PIC"
              (filename . "*.asm"))
            ("Assembly" ;; all org-related buffers
              (mode . asm-mode))  
            ("Programming" ;; prog stuff not already in MyProjectX
              (or
                (mode . c-mode)
                (mode . perl-mode)
                (mode . python-mode)
                (mode . emacs-lisp-mode)
                ;; etc
                )) 
            ))))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-switch-to-saved-filter-groups "default")))

(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Tags
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command
  ;;(message
   ;;(format "ctags %s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
   (format "ctags -e -R \"%s\"" (directory-file-name dir-name)))
  )


;; Interface to git
(require 'egg)


;; ido makes competing buffers and finding files easier
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido) 
(ido-mode 'both) ;; for buffers and files
(setq 
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"

  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"

     "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
  ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
  ido-case-fold  t                 ; be case-insensitive

  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30   ; should be enough
  ido-max-work-file-list      50   ; remember many
  ido-use-filename-at-point nil    ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ; don't use url at point (annoying)

  ido-enable-flex-matching nil     ; don't try to be too smart
  ido-max-prospects 8              ; don't spam my minibuffer
  ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; when using ido, the confirmation is rather annoying...
 (setq confirm-nonexistent-file-or-buffer nil)


(require 'revbufs)

(require 'gas-mode)

;; For fullscreen functionality
(require 'darkroom-mode)

;; Fringes are the margin areas where truncate or wrap arrows are shown.
;; Set their size here.
(set-fringe-mode '(4 . 2))

(put 'dired-find-alternate-file 'disabled nil)

;; alternative python mode
 (require 'python-mode)
 (autoload 'python-mode "python-mode.el"
   "Major mode for editing Python source." t)
 (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
 
;; pymacs
 (setenv "PYMACS_PYTHON" "c:/program/python2.7") 
 
 (autoload 'pymacs-apply "pymacs")
 (autoload 'pymacs-call "pymacs")
 (autoload 'pymacs-eval "pymacs" nil t)
 (autoload 'pymacs-exec "pymacs" nil t)
 (autoload 'pymacs-load "pymacs" nil t)
 (require 'pymacs)
 ;;(eval-after-load "pymacs"
 ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
 
 
;; iPython integration
 (add-to-list 'interpreter-mode-alist '("python" . python-mode))
 (require 'ipython)
 (setq py-python-command-args '("-pylab" "-colors" "LightBG"))
 (setq ipython-command "ipython")

 ;;(when (executable-find "ipython")
 ;;    (require 'ipython nil 'noerror))
 ;;(when (featurep 'ipython)
 ;;  (setq python-python-command "ipython")
 ;;  (autoload 'py-shell "ipython"
 ;;    "Use IPython as the Python interpreter." t))

(setq load-path
          (append (list nil "~/.emacs.d/includes/deft")
                  load-path))
(when (require 'deft nil 'noerror)
  (setq
   deft-directory "~/.deft")
  (global-set-key (kbd "<f9>") 'deft))


(defun insert-function-header()
  "Insert a C function header above the current function."
  (interactive)
  (setq function-name (c-defun-name))
  (beginning-of-defun)  ; leave mark at the old location
  (insert "//------------------------------------------------------------------------------
// Function:    ")
  (insert function-name)
  (insert "
//------------------------------------------------------------------------------
// Description: 
// Input:       
// Output:      
// Notes:       
//------------------------------------------------------------------------------
")
  (word-search-backward "Description:")
  (move-end-of-line nil))

(define-key global-map "\C-x\C-hf" 'insert-function-header)


(defun insert-c-file-header()
  "Insert a C file header."
  (interactive)
  (insert "/*----------------------------------------------------------------------------
Copyright (c) 2011 Bellman & Symfon AB
This code is the property of Bellman & Symfon AB and may not be redistributed 
in any form without prior written permission from Bellman & Symfon AB. 
----------------------------------------------------------------------------*/

//******************************************************************************
// Module constants
//******************************************************************************

//******************************************************************************
// Module variables
//******************************************************************************

//******************************************************************************
// Function prototypes
//******************************************************************************

//******************************************************************************
// Function definitions
//******************************************************************************

//******************************************************************************
// Internal functions
//******************************************************************************
"))


(defun insert-h-file-header()
  "Insert a H file header."
  (interactive)
  (insert "/*----------------------------------------------------------------------------
Copyright (c) 2011 Bellman & Symfon AB
This code is the property of Bellman & Symfon AB and may not be redistributed 
in any form without prior written permission from Bellman & Symfon AB. 
----------------------------------------------------------------------------*/

#ifndef _INCLUDED
#define _INCLUDED
#endif // _INCLUDED
"))