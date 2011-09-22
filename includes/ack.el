;; ack.el
;; With credit to w32-find-dired.el
 
;; Copyright (C) 2008 Kim van Wyk and Johan Kohler
 
;; This file is not currently part of GNU Emacs.
 
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.
 
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
 
(require 'compile)
(require 'thingatpt)
 
(defvar ack-command "ack" "The command run by the ack function.")
 
(defvar ack-mode-font-lock-keywords
  '(("^\\(Compilation\\|Ack\\) started.*"
     (0 '(face nil message nil help-echo nil mouse-face nil) t))))
 
(defvar ack-use-search-in-buffer-name t
  "If non-nil, use the search string in the ack buffer's name.")
 

(defvar ack-regexp-alist
;;  '(("^\\S +$" ;; match a file -- this could be better
  '(("^[a-zA-Z]:/.+$"
     0          ;; The file is the 1st subexpression
     )
    ("^[0-9]+:" ;; match the line number
     nil        ;; the file is not found on this line, so assume that it's the same as before
     0          ;; The line is the 0'th subexpression (the whole thing)
     ))
  "Alist that specifies how to match rows in ack output.")


(setq compilation-error-regexp-alist
      (append compilation-error-regexp-alist
	      ack-regexp-alist))


(define-compilation-mode ack-mode "Ack"
  "Specialization of compilation-mode for use with ack."
   nil) 
 
(defun ack (dir pattern args)
  "Run ack, with user-specified ARGS, and collect output in a buffer.
While ack runs asynchronously, you can use the \\[next-error] command to
find the text that ack hits refer to. The command actually run is
defined by the ack-command variable."
  (interactive (list (read-file-name "Run ack in directory: " nil "" t)
                     (read-string "Search for: " (thing-at-point 'symbol))
                     (read-string "Ack arguments: " "-i --group --type-add asm=.ss -n" nil "-i --group --type-add asm=.ss --type-add asm=.inc -n" nil)
                                  ))
  ; Get dir into an the right state, incase a file name was used
    (setq dir (abbreviate-file-name
               (file-name-as-directory (expand-file-name dir))))
    ;; Check that it's really a directory.
    (or (file-directory-p dir)
        (error "ack needs a directory: %s" dir))
 
  (let (compile-command
        (compilation-error-regexp-alist ack-regexp-alist)
        (compilation-directory default-directory)
        (ack-full-buffer-name (concat "*ack-" pattern "*")))
;;    (save-some-buffers (not compilation-ask-about-save) nil)
    ;; lambda defined here since compilation-start expects to call a function to get the buffer name
    (compilation-start (concat ack-command " " args " " pattern " " dir) 'ack-mode
                       (when ack-use-search-in-buffer-name
                         (function (lambda (ignore)
                                     ack-full-buffer-name)))
                       (regexp-quote pattern))))
 
(provide 'ack)
