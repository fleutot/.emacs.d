(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; For local libs
(add-to-list 'load-path "~/.emacs.d/includes")

;; Remove unnecessary GUI elements
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq confirm-kill-emacs 'y-or-n-p)

;; New window pop-up vertical split threshold.
;; Windows with a fewer number of visible lines may not be split.
(setq split-height-threshold 120)
(setq split-width-threshold 150)

(when (member "Terminus" (font-family-list))
  (set-frame-font "-xos4-Terminus-normal-normal-normal-*-12-*-*-*-c-60-iso10646-1")
  (add-to-list 'default-frame-alist '(font . "-xos4-Terminus-normal-normal-normal-*-12-*-*-*-c-60-iso10646-1")))

(setq auto-mode-alist (cons '("Makefile\\." . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".ts$" . c-mode) auto-mode-alist))
(setq auto-mode-alist (append auto-mode-alist '(("\\.cflow$" . cflow-mode))))
(add-to-list 'auto-mode-alist '("\\.bash_aliases\\'" . sh-mode))


;;; ----- Modes ---------------------------------------------------
;;; See https://emacs.stackexchange.com/questions/73080/indent-region-does-not-respect-my-c-mode-style
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-enable-indentation nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  :hook (
         (c-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  ;:bind ("M-." . lsp-find-definition)
  :ensure t)

(use-package lsp-ui
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-show-with-mouse nil)
  :ensure t)

(use-package flycheck
  :init
  (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-display-errors-function #'flycheck-display-error-messages)
  :ensure t)
;; Show flyckeck diagnostics at location in a little frame
;;(use-package flycheck-posframe
;;  :ensure t
;;  :after flycheck
;;  :config (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))
;;; Show flycheck error list on the bottom of current buffer
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))

(use-package dap-mode
  :ensure t)
(require 'dap-gdb-lldb)
;; This seems required too: M-x dap-gdb-lldb-setup
;; Project specific debug template (should be in the project itself?):
(dap-register-debug-template
 "GDB::dwm"
 (list
  :type "gdb" :request "launch" :name "GDB::Run"
  :args "DISPLAY=:1" ;; this line breaks it. But how to I pass DISPLAY?
  :target "/home/gauthier/src/dwm/dwm" :cwd "."))

(use-package go-mode
  :ensure t)

(use-package treemacs
  :ensure t)

(use-package counsel
  :ensure t)

(use-package dtrt-indent
  :ensure t)

;;; I get a "Cannot load" on that??
;;(use-package which-key
;;    :config
;;    (which-key-mode))

;;;; How to install languages??
;;(use-package tree-sitter-langs
;;  :ensure t)
;;
;;(use-package tree-sitter
;;  :init
;;  (tree-sitter-require 'c-sharp)
;;  (tree-sitter-require 'c)
;;  (tree-sitter-require 'go)
;;  (tree-sitter-require 'python)
;;  :ensure t)
(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(use-package magit
  :ensure t)

(use-package highlight-symbol
  :ensure t
  :config
  (setq highlight-symbol-idle-delay 0)
  (setq highlight-symbol-on-navigation-p t)
  (add-hook 'prog-mode-hook #'highlight-symbol-mode)
  (add-hook 'prog-mode-hook #'highlight-symbol-nav-mode)
  (global-set-key (kbd "C-c h") 'highlight-symbol-at-point)
  (global-set-key (kbd "C-c n") 'highlight-symbol-next)
  (global-set-key (kbd "C-c p") 'highlight-symbol-prev)
  (global-set-key (kbd "C-c H") 'highlight-symbol-remove-all))

(use-package robot-mode
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package intel-hex-mode
  :ensure t)

;;; org mode
;; Don't convert _ and ^ unless surrounded by braces
(setq org-export-with-sub-superscripts '{})
(add-hook 'org-mode-hook 'auto-fill-mode)
(setq org-startup-indented t)
(setq org-ellipsis " \u25bc")

(use-package protobuf-mode
  :ensure t)

(use-package csharp-mode
  :ensure t)

(use-package ws-butler
  :ensure t)

(use-package writegood-mode
	     :ensure t
	     :bind ("C-c g" . writegood-mode)
	     :config
	     (add-to-list 'writegood-weasel-words "actionable"))

;; ws-trim, unlike ws-butler, allows for trimming trailing whitespace
;; already at moving from line.
(require 'ws-trim)
(setq ws-trim-level 1) ; 1 -> only modified lines are trimmed.
(add-hook 'ws-trim-method-hook #'ws-trim-trailing)
;;(setq ws-trim-method-hook '(ws-trim-trailing))

(defun my-prog-mode-hook ()
  (setq show-trailing-whitespace t)
  (ws-butler-mode)
  (highlight-symbol-mode)
  ;;(flyspell-prog-mode) ;; This makes Python unusable (freeze)
  (flycheck-mode)
  (auto-fill-mode)
  (writegood-mode)
  (ws-trim-mode)
  ; Dupes highlight e.g. two `fi` in a row in bash
  (writegood-duplicates-turn-off)
  ;;(dtrt-indent-mode)
  (if (> emacs-major-version 26)
      (progn
        (display-fill-column-indicator-mode)
        )
    (fci-mode) ; fci and hl-block don't work well together
    ))
(add-hook 'prog-mode-hook 'my-prog-mode-hook)

;; Display whitespace characters.
(require 'whitespace) ;; builtin
(global-set-key (kbd "C-c b") 'whitespace-mode)
(delete 'indentation whitespace-style) ; no warning about indent with spaces
(delete 'lines whitespace-style) ; remove whole highlight of long lines
(add-to-list 'whitespace-style 'lines-tail) ; highlight the tail of long lines

;; --- compilation mode ---
;; From https://emacs.stackexchange.com/a/13137/6655
(defun highlight-selected-error ()
  "Highlight the line selected in the buffer in compilation mode.
Useful for highlighting an error after running 'next-error'"
  (with-current-buffer next-error-last-buffer
    (hl-line-mode 1)))
(add-hook 'next-error-hook 'highlight-selected-error)
(add-hook 'compilation-mode-hook (lambda () (visual-line-mode 1)))
(add-hook 'compilation-mode-hook (lambda () (hl-line-mode 1)))
(add-hook 'compilation-minor-mode-hook (lambda () (visual-line-mode 1)))
(setq compilation-scroll-output 'first-error)
(setq compilation-context-lines 15)

;;; I get a "Cannot load" on that??
;;(use-package flycheck-mode
;;  :ensure t)

;; ido makes competing buffers and finding files easier
(ido-mode 'both) ;; for buffers and files
(setq
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"

  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
     "^\*compilation" "^\*GTAGS" "^session\.*" "\*GNU Emacs\*")
  ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~/src")
  ido-case-fold  t                 ; be case-insensitiver

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

;; Unnecessary since the completing-read function below?
;;;; ido completion for M-x
;;(global-set-key
;; "\M-x"
;; (lambda ()
;;   (interactive)
;;   (call-interactively
;;    (intern
;;     (ido-completing-read
;;      "M-x "
;;      (all-completions "" obarray 'commandp))))))

(defvar ido-enable-replace-completing-read t
  "If t, use ido-completing-read instead of completing-read if possible.

    Set it to nil using let in around-advice for functions where the
    original completing-read is required.  For example, if a function
    foo absolutely must use the original completing-read, define some
    advice like this:

    (defadvice foo (around original-completing-read-only activate)
      (let (ido-enable-replace-completing-read) ad-do-it))")
;; Replace completing-read wherever possible, unless directed otherwise
(defadvice completing-read
    (around use-ido-when-possible activate)
  (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
          (and (boundp 'ido-cur-list)
               ido-cur-list)) ; Avoid infinite loop from ido calling this
      ad-do-it
    (let ((allcomp (all-completions "" collection predicate)))
      (if allcomp
          (setq ad-return-value
                (ido-completing-read prompt
                                     allcomp
                                     nil require-match initial-input hist def))
        ad-do-it))))

;;; ----- Programming formatting -------------------------------------
(defconst mira-c-style
  '((c-basic-offset . 4)
    (indent-tabs-mode . nil)
    (tab-width . 7)
    (c-comment-only-line-offset . (0 . 0))
    (c-lineup-C-comments . 0)
    (c-electric-pound-behavior. alignleft) ; Pre-processor macros go to column 0
    (paragraph-start . "[ 	]*\\(//+\\|\\**\\)[ 	]*$\\|@param\\)\\|^")
    (c-offsets-alist . ((topmost-intro-cont    . 0)
                        (statement-block-intro . +)
                        (knr-argdecl-intro     . 5)
                        (substatement-open     . 0)
                        (substatement-label    . +)
                        (label                 . +)
                        (statement-case-open   . +)
                        (statement-cont        . +)
                        (arglist-intro  . +)
                        (arglist-close  . 0)
                        (arglist-cont-nonempty . +)
                        (access-label   . 0)
                        (arglist-cont-nonempty . +)
                        (cpp-macro . [0])
                        )))
  "Mira C Programming Style")
(c-add-style "Mira C" mira-c-style)
(setq c-default-style "Mira C")

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
  (c-set-offset 'inextern-lang 0) ; No extra indent in an extern block (#ifdef __cplusplus)
  (when (derived-mode-p 'c-mode 'c++-mode 'java-mode))
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;; ----- Mode line --------------------------------------------------
(setq column-number-mode t)

;;; ----- Themes -----------------------------------------------------
; Color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'bisque t)

;;; ----- My key definitions -----------------------------------------
;; --- smart home behaviour ---
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

;; --- search ---
;;;(global-set-key "\M-s" 'project-find-regexp)

(require 'thingatpt)
(defun my-git-grep-at-point ()
  (interactive)
  (vc-git-grep (thing-at-point 'symbol) (vc-git-root buffer-file-name))
  )
(global-set-key "\M-s" 'my-git-grep-at-point)

(defun my-git-grep ()
  (interactive)
  (vc-git-grep (read-regexp "Search regex: ") (vc-git-root buffer-file-name))
  )
(global-set-key "\M-S" 'my-git-grep)

;; --- find other file ---
(defun find-other-file-no-include ()
  (interactive)
  (ff-find-other-file nil t))

(defun find-other-file-no-include-other-window ()
  (interactive)
  (ff-find-other-file t t))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (local-set-key (kbd "M-o") 'find-other-file-no-include)))
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (local-set-key (kbd "M-O") 'find-other-file-no-include-other-window)))

;; --- smart kill-line ---
;; On end of line, strips white space from following line.
(defadvice kill-line (after kill-line-cleanup-whitespace activate compile)
      "Cleanup whitespace on 'kill-line'."
      (if (not (bolp))
	  (delete-region (point) (progn (skip-chars-forward " \t") (point)))))

;; --- Zoom applies to the whole frame ---
; Taken from a comment in package frame-cmds.el (elpa). Probably not working for versions under 22.
(defun my-enlarge-font (&optional increment frame)
    "Increase size of font in FRAME by INCREMENT.
Interactively, INCREMENT is given by the prefix argument.
Optional FRAME parameter defaults to current frame."
    (interactive "p")
    (setq frame  (or frame  (selected-frame)))
    (set-face-attribute
     'default frame :height (+ (* 10 increment)
                               (face-attribute 'default :height frame 'default))))
(defun my-zoom-in ()
  (interactive)
  (my-enlarge-font 2))
(defun my-zoom-out ()
  (interactive)
  (my-enlarge-font -2))
(global-set-key (kbd "C-x C-+") 'my-zoom-in)
(global-set-key (kbd "C-x C-=") 'my-zoom-in)
(global-set-key (kbd "C-x C--") 'my-zoom-out)
(global-set-key (kbd "C-x C-0") 'my-zoom-out)

;; --------------------------------------------------------------------
(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("64a46f7b85d0d8b640a21ed8c3e577bc8774974e71f3df7e2e9df18879dee993" "3aacadf67e421a837c47284854060c7d5bb62c4b9bdf03a92e655a969c0ac323" "2158fab79919b07b8c41d388d77bb3f66c0572ce856fe3aab1fa0d6520a89f40" "0e0cacf8e0ec7b1de25e5c440c35ecf33620038de1bb80814d1c7bb43d534805" "b34048d609ded633cdd7052256cbf87d2c8109852d0a9a47ca9ed505ceb78f7b" "3d68356198d520570aa636fb8a66f3b959ba18632dd73bc7dc04a98cc28a5593" "1c19b68c2ffcd0b53a8bf3b7ebecd66ba745b6b6e191f7c7fa2720c12a94164b" "ddca32451ac164f5f0d89fd97e3e039e1897d8948fcef4ea845c4941c585eb37" "641818eabfebf65644eb2bf19016665295e85b99406fefc38fadf9b702b3d109" "5d8a411973e6c709ced3d74d815b8f76f682246687f7338bf5269963b89585cd" "0f3d58666b0f7e7539677ab03f71f6df3f079a9ebc444d0ce211c8cb01d3392b" "ac0e741c51ff61dd7e15b209515e35795bac69ed75473617afe2a8420e0edd9f" "80a258b561ca0434b31f1d14cb853fd5919ac14a7267fc006b0b5854a8417135" "42e0bcef76316c29347f29b33a699ac7b5c6cd18715cf1cd3e79e8bf9a6a5466" "24d64cbf6479da1b5ea0699ad10555aa2f9b1a3aebd08cd6f8804547ca5283b9" "344b2a3a4d96b392ca810c95f65b3de564cbbab51fb41cfb4a752a00ce3056f4" "0c7e222fd484fd65a22881aede855249a9738db79ba95e497d792997fedd51f1" "11ae64e6fad6090e0c50ee77ffbfbb031940a261e5509a9fccc34a127dd6f238" "4929e019ff782dbd7aaa2962b077d3ce30617fd67276091875e2dbab6fd38db1" "3267b287b5d7bc0f6ae52b4c58b9a1a7d9f55d7db4d270de4369418e27a0fdde" "ea51fdbad2a3c0817f89295ce6662002d69a1586724bab290ca3861866457c7c" "a21f194824b5b6f6ffdad9b886376fc7d79b453a4a43c62112471e70942a3ec7" "89075e1074987d149b142413cc703ab3f6e6a206d0f2b889216c961a7d5519ce" "f61e5b67769f4b0c224403a1b80348a370f9852f0d1b3cb3110d58ee09b3280f" "2fd1984837f6ff2fa8269ca1ea00ac77c3c356fa31df3104306f617199197523" "3567e721cc27da3c1dca5a84d76557db8cbb148af942957d1b8b0d580a1fe454" "0da36ac06fbdab6526de7e35954b01c181fef81b9d46b18f60c7a50babda877f" "1e2ff7c10e1254cf1951057641ee846c9f2dc11d018c5c1e13b51b0337bc01d0" "1bbb8f6a10b20f0269c99e8a35625e941080138b7fb9d0b87b42c9a0b5143eaf" "4eb87b023ca55625af1598aa6aacc9f723292f07667f75834e21afe63fddcd36" "d121db8ab80295939943d369f9f241a73171ac97b8e0de2d3505162241c7ba8d" "2d8961a4f11fccc665bd8ea04097ee1a8af40628f7a889f6a09feb81b8fc24ae" "d5ea2385740b04fc3a2762616418445436ff5e0a8566b7525d124ab1041aec5f" "b04eccdc3c57ff50952397bb4422b9af6c900f0111040cb8f81193d30ab99b87" "a04f2b9cf7070fabb0f96fc2ce76a3888af211de8b100482471058dc679ad9ee" "a103ec629e2b731b27dffd369948bf6fb72668995ed841fecbba8b380db663f5" "ca2c929a670770b9936b37bab3e25f231cb2fb32cca7e602a623c316e28243ce" "62ebbd1858fb03846e639629bf77d782241574f600b946f5ad46f1d370641431" "f33a8a7fc53ce5899fc2f63332053eb6c90914defc4ee8c34aedc0e89e509891" "6d98ced4486ca69703b8e81fb706757ff4b7fa7b2fea4d97fc7ce516385a0025" "d66d715604f6b7a939584444096dce1d5df4fb0578ecedbbb6d8931f19e97633" default))
 '(package-selected-packages
   '(go-mode hideshow-mode py-autopep8 flycheck-posframe flycheck dap-gdb-lldb dap-mode dtrt-indent csharp-mode lsp-pyright tree-sitter-langs tree-sitter-c tree-sitter hl-block-mode writegood-mode ws-butler which-key flycheck-mode robot-mode counsel highlight-symbol lsp-treemacs lsp-ui lsp-mode magit use-package))
 '(safe-local-variable-values
   '((eval when
	   (fboundp 'rainbow-mode)
	   (rainbow-mode 1))
     (c-default-style . "linux")
     (indent-tabs-mode t)
     (projectile-project-root . "/home/gauthier/src/airglow_fw"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
