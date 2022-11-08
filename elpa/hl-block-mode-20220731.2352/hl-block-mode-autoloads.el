;;; hl-block-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "hl-block-mode" "hl-block-mode.el" (0 0 0 0))
;;; Generated autoloads from hl-block-mode.el

(autoload 'hl-block-mode "hl-block-mode" "\
Highlight block under the cursor.

This is a minor mode.  If called interactively, toggle the
`Hl-Block mode' mode.  If the prefix argument is positive, enable
the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `hl-block-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(put 'global-hl-block-mode 'globalized-minor-mode t)

(defvar global-hl-block-mode nil "\
Non-nil if Global Hl-Block mode is enabled.
See the `global-hl-block-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-hl-block-mode'.")

(custom-autoload 'global-hl-block-mode "hl-block-mode" nil)

(autoload 'global-hl-block-mode "hl-block-mode" "\
Toggle Hl-Block mode in all buffers.
With prefix ARG, enable Global Hl-Block mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Hl-Block mode is enabled in all buffers where `hl-block-mode-turn-on'
would do it.

See `hl-block-mode' for more information on Hl-Block mode.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "hl-block-mode" '("hl-block-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; hl-block-mode-autoloads.el ends here
