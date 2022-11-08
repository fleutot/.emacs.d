;;; robot-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "robot-mode" "robot-mode.el" (0 0 0 0))
;;; Generated autoloads from robot-mode.el

(autoload 'robot-mode "robot-mode" "\
Major mode for editing Robot framework files

\\{robot-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.\\(robot\\|resource\\)\\'" . robot-mode))

(register-definition-prefixes "robot-mode" '("robot-mode-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; robot-mode-autoloads.el ends here
