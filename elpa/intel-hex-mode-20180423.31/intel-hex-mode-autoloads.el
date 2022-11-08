;;; intel-hex-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "intel-hex-mode" "intel-hex-mode.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from intel-hex-mode.el

(autoload 'intel-hex-mode "intel-hex-mode" "\
Major mode for the Intel Hex files.
\\<intel-hex-mode-map>
\\[intel-hex-update-line-checksum]	- Updates the line checksum.
\\[intel-hex-update-buffer-checksum]	- Updates the checksum for all lines in
the current buffer.

Variables specific to this mode:

  intel-hex-some-variable            (default `value')
       Some variable.

This mode can be customized by running \\[intel-hex-customize].

Turning on Intel Hex mode calls the value of the variable
`intel-hex-mode-hook' with no args, if that value is non-nil.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.hex\\'" . intel-hex-mode))

(register-definition-prefixes "intel-hex-mode" '("intel-hex-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; intel-hex-mode-autoloads.el ends here
