; Directory to put various el files into
(add-to-list 'load-path "~/.emacs.d/includes")

; Add file associations
(setq auto-mode-alist (cons '(".ss$" . asm-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".inc$" . asm-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".m$" . octave-mode) auto-mode-alist))
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".rhtml$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Makefile\\." . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("COMMIT_EDITMSG" . git-commit-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".ts$" . c-mode) auto-mode-alist))

(setq package-enable-at-startup nil)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

; Give back a hard newline with no indentation. Use C-j for newline-and-indent.
(eval-after-load 'asm
  '(define-key asm-mode-map (kbd "RET") 'newline))

; loads ruby mode when a .rb file is opened.

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
;(global-set-key "\C-x\C-c" 'null)
;(global-set-key (kbd "M-<f4>") 'save-buffers-kill-emacs)

(show-paren-mode 1)

;; New window pop-up vertical split threshold.
;; Windows with a fewer number of visible lines may not be split vertically.
(setq split-height-threshold 120)
(setq split-width-threshold 150)


;;;;;;;;;;;;;;; EXPERIMENTAL, not working ;;;;;;;;;;;;;;;;
;; Change background color for read-only buffers
;;(add-hook 'find-file-hooks
;;          (lambda ()
;;            (when buffer-read-only
;;              (set-background-color "black"))))
;;
;;(defadvice toogle-read-only (after toggle-read-only-color)
;;  "Toggle background color for read-only buffer"
;;  (lambda ()
;;    (when buffer-read-only
;;      (message "the advice is there!"))))
;;      ;(set-background-color "black"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Smart kill-line on end of line, strips white space from following line.
(defadvice kill-line (after kill-line-cleanup-whitespace activate compile)
      "cleanup whitespace on kill-line"
      (if (not (bolp))
	  (delete-region (point) (progn (skip-chars-forward " \t") (point)))))


;(set-default-font "-outline-Lucida Console-normal-normal-normal-mono-11-*-*-*-c-*-iso8859-1")
; Default font 9 pt
;(set-default-font "-outline-Lucida Console-normal-normal-normal-mono-11-*-*-*-c-*-iso8859-1")
;(set-default-font "Lucida Console-9")
;(set-face-attribute 'default nil :height 100)

; For use in Unity with scaling 0.75
;(set-default-font "Ubuntu Mono-13")
; For use without scaling
(when (member "Ubuntu Mono-10" (font-family-list))
  (set-frame-font "Ubuntu Mono-10")
  (add-to-list 'default-frame-alist '(font . "Ubuntu Mono-10")))
;; set a default font
(when (member "Terminus" (font-family-list))
  (set-frame-font "-xos4-Terminus-normal-normal-normal-*-12-*-*-*-c-60-iso10646-1")
  (add-to-list 'default-frame-alist '(font . "-xos4-Terminus-normal-normal-normal-*-12-*-*-*-c-60-iso10646-1")))

(when (eq system-type 'darwin)
  ;; on a mac, SF Mono installed by selecting all otf files in /Applications/Utilities/Temrinal.app/Contents/Resources/Fonts/,
  ;; right-click, Open, then select all and Install.
  (set-face-attribute 'default nil
                      :font "Monaco-10:antialias=false"))

; From https://emacs.stackexchange.com/a/13137/6655
(defun highlight-selected-error ()
  "Highlight the line selected in the buffer in compilation mode.
Useful for highlighting an error after running 'next-error'"
  (with-current-buffer next-error-last-buffer
    (hl-line-mode 1)))
(add-hook 'next-error-hook 'highlight-selected-error)

(add-hook 'compilation-mode-hook (lambda () (visual-line-mode 1)))
(add-hook 'compilation-mode-hook (lambda () (hl-line-mode 1)))
(add-hook 'compilation-minor-mode-hook (lambda () (visual-line-mode 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(ansi-term-color-vector
   ["#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"] t)
 '(compilation-context-lines 15)
 '(compilation-scroll-output (quote first-error))
 '(compile-command "make -C ~/code/mira")
 '(custom-safe-themes
   (quote
    ("86e67f4402004edf77d00960ee42e6bf9e9b6c134fd25fb058416268c564044c" "8846d6405ddf6b08ca267d37d0aaff902e0fcafa333159346a32fe043cc07f90" "bbc163a136167ba5790d030d5fb552c0373a9b790fcaf559941103cdf373327b" "19dcfd45bf17489c4d2cc97d7c150e20ebe0368398d5de7f84dfb803001e496a" "62c19ecba69eec2ff6bf30d2bfff0920902d74d488a5e92275d9209fe5ae110c" "f565b4425a5b1991bbcfe54662d10ff2194e832e38b26edd30871a8cb0ec4bc5" "86bb4d2542806614a41e4ab4d06f034da702da20e6e8aa1a369d3e1fd8aa6dfb" "cf2b4e2fd45a4e9f325028da96e53f29b81a94dee8f5743368cc03f1d70ca875" "8b99393d3c36f1eb7ceec2aafd2513e47f439705d8d2ee69280df2312224c186" "54dec3fa16f5f9b2ce8f1db56fe004be602a9d98eaaf0c3d0d24d08abf2003be" "da164ebc03ea9ef520e60da31787635e4571d83e88a3c32f065f83863f9612d8" "fc74a89df396396f7eeb2135b226e5a8e6c8048b329890911abd63d7058edf5d" "d30005720928614e87e2c0590b29ee6b62b5e4f81d9443fa1e6f341c656b7098" "293258e026355445d9648c40f11e49c6c563a03d5068d23eb1efecc166073825" "97ec953afbcfdd562b51753b5c9a7e127d35ec1826c3f82406b2d476e9e21d6e" "9a10bf1c11a8fdbd54188157e3679535b7b708a9d6f5231acc10e3123edc9561" "35b81ea5065adab81a8c952d5d082c178b1eb03070a1cc83293a3c24f63f248f" "7d884f65f2a46cc2b81f2eda346f6a70f82797a8cf762b43a3266c68f47217f1" "beeff3a6863357e4dc1d443a31ccaeed1718974d6a4b2faceba5fbd02a0d297b" "50afcb262688467c180951a2d9222a4a686ea3f8ed10daecd798bf86ea2a2d7d" "8f868050b93ae9a2e16a03f7a45675da161077f3e8bb70486096e76a40ba8c92" "ae131ed15754d3ce6b5915c9bfb7874d6a924a1c3ae051cbadb1818e82f33ce9" "9af691590d23f258ff78c63cfd661afb3aa296a93c442577b484e213a249825e" "23494e48b8ef148dc4589a2925c73373c12557d71b7a3f95ce3f9837de37b614" "029189abfb0a4460b52b71e76c73b347606502f337f041846ab0c2b060f89dfc" "7a7746ce901804e9cbdbd172c98c07f5b56caf458cc7fc02da6313f6a6dcdb69" "d728a7607c4db58d28723ac6ad28fb7dd2cfd786bb08e1118d3a985023e9e437" "14ed5fda7496d2f0b9ae972bdcd47c8d89c40dd182d0086c6eed41674bf3b1c6" "acf990f6f67a92194b6cd577cce1e2d2413a692c552ed3fd467004f84a44bd6c" "290cd3d52b145de4599dcade6078b285fdd4e6ffd91396cc525c0395e94e1b51" "a9ac9b650de338a4555f8ede1c198df6ccdb03d3da9c63b59c0c84d78c0b99df" "d70f00294e9128f0984e04ff95861ec45473c9ada2b7e739878c0ee3191fbc05" "3ea5184ecb0576c2650d05c59664ae51eba8c7eccd68878530bf351f8c443a31" "85e125707dd13ef4f0d4ece3665b84e6b69b7f9118aaf4c1e31e40ba4327ce32" "0b6ee64e7c4ca68eacc5a7e111d594ce6286997156b6b25eca08aa41f3d2be11" "d97b03d1f991e112d801f080fee93e49861920b4cb293d3158ad90484dca5bf0" "f69ed3207907d45543d289c65eb7e931cedde13cdfc8b01f311c29a6721ac0e0" "eb5f99a7b9f5c3a190e2f501e45c6ff9403f1681f98befddf2fbd0c32b11bd3f" "4fdcd70eae5e6c91488cfd8f5181f543b2ddcfc1ce51a643caef9021798a7653" "4e6b10fa3568c284b1e228c90339bbabd1a4049998efc4d61e98080b18382de0" "a97673ac68f5874959189ea5392af91a8aa3108066f515ea1dfde7ceed66e3eb" "abf3138b20f86500c056806e2055ff0e9169a9edb44b393125759e7dcce9ae38" "9afa499fa688cc01d394ebcde709c247964cc0bc251b2e7bfd9757ac02ad4c3d" "131a22c5c56613646d1aad3ac1586f1165e60996db0dd2b8cb6772e6dd886a55" "5dcd12e865596e9653d34bb6e35937ec77c9ab15e66c2703b4ae911cf9a99812" "cf5a02828c16542c83adb52c5662ea1b49fc1461626d19fc7073c0e39f5e78b6" "3a32de2a4d748eb0f8736e6cc43b2a0756d1428d513573182836eb4d53d214ed" "b2c122b0526f3c475767667cedcd5f99ab20e1d4e4972255abaef45173ae53b2" "99410a536f8e65655c47dd2d86c838dcaca3278e6123106c445bf7b6ff0fe535" "82f798ffb844e819e8b1c7a1b8189ec47a476ede7de365d36e4cfb063f61e502" "e745eaaf22c2c7b57ec64dd7d5c2d9cdb5f53a5fdbbe79d870e2d5941e633417" "bdd8bdf0582a48b14443fce6df668c88eb4af30b41f2ae3253a53f860ccb1dfb" "3e6097eeb8b13417299e85e6f70df4d2a5f551e7ea23710280e5e24b85befbb8" "3fb2692635aa3a586c06927bd3c4499416b4671845411c4e7b304f7159e0862f" "2bfb0b73a3954ac0a8d24e2d051dd64ec1cece4044f192755dc236d5144d487e" "6f2a4af1268cc6c039cbd7e99589befeed5473b207ba704592738d825a08b304" "f0810859a2413353062a1ee64660fc7d692dc9d807a0fcdbaa8c5440c13a7dc8" "f4bad575271c75f4b289b6d08a71c534feef130f0a3aaf3d3100302e939d481d" "8ebc2294f45e93d12cb3c4427677b8ccfd39ab42b03b8c972d45aecfc80ded62" "061434f3e534b498828adc626e87dc0a78510c9b875f516a70a64dd9b123d2c1" "abbb4aae1bc5793473d9eded06187e56a58f8954989b7a034f958ac8686e6a21" "3913e7a00d03d30b128c78244586add22c8746bee6ea780aabd4da3776b8f8b3" "1574e7f585086ddc046786456430232322e2bbe453c07c8c4eeb04c000045937" "65dfecde0ade57145baf2dddc994122998df196956bc7a8567ac81693879c914" "f3dfabf0305c76140b0238ce663fff300cfc9e696b9e0a393d8bc2b27e431393" "3805745a0440d404f19fbdf82261ff176676220d37a29dbb1ef9758efa9362c7" "a665a17f0c0dcb626ce2140aaf6107ba43e95d75f5a00c1f617c252714cfd0cc" "8a9a43ff0c3e9da06da0fac51ecfe3520494144471734dcbb2f2448ea1ca6194" "1af8253e1e8aafa70ee72f3dd9b69604ea92412ff24c78fb1b6d1e341af55272" "f06add643615294e65d7c886bb7913432a1d6e59fd80e0e498fd81342c9057b3" "35068482c5374f259dcb7d3a2a6cfbfbd82ec12491e9130332711a38c4a78703" "fbadfaa790a5f0fc7b884781000236bcb87503a539f8c9571533de30bf29665b" "8decf4470bb3d30bc54c835bc7d3ed246cfde63d7a6267711e19f5f282cdf76d" "e6f803d7c8439ac1c2805fcc8a95a79250e129ce2d8f00344a0484b8ebc6ced2" "e15a578d4e2d8ef761019bc84b07bbe0642a36ea735626c35bb0f7dfae8b5f73" "3fd0fda6c3842e59f3a307d01f105cce74e1981c6670bb17588557b4cebfe1a7" "bfc3d92754a1f0af6bc3653b363f6cf3a0bd608f8a715a42e1bb416cc35e6b01" "36f3f367fc24b73917831203d0b2ef688e96da0315bccfe1a20cb48b8b6b2b7a" "d4b199a40ea2b66d80580ed16a9284244b34d62d6f85cc491e983c0870d6aad6" "b6d776913491a9ff9d24d893f72cf7d0054c079f646b2a9e5c915ce6b0f4fad7" "cfb6f9e7117a4cbc25b668ea5810d2e51795fca610ecdd5375af1e47f11a2d7b" "65426191cc767ef46550316aaedb390c964ff5106fb4915ced70d54b788585ee" "fd98fe5ad72432fde6d75fdaed432abab31d2020a584799f487fa2134554ba78" "6e4b0714df5cb9527106181f3ae7b3fd8d8dff6de5ddadbe8ef94e5b170185c7" "aef56024ff845bfe4ea2394247501d659ca45ddd28ae31982b29b1cb43e2b2f5" "067e5e21a9b8af74094c4c67f2468669c8e92743b19b658b458fa0146b6fe56e" "c90696c8d95e6f165ceeced9f35b200fe4c4c0eaff6dd6a0e6ea69f96ad200a9" "d64aea67b62b5219247814ff95026c1119bd328612b005fc9594dc22896735f6" "9b0fb159ce03afc785ebed71d80e2b3c64a99a2b616c293c9b16a1fbf85170d7" "4753abba0ea8b1214e9859beefa2448a8cb84cf0d6ff372d54faad67328adb59" "4905b46c5114003d08de39aa69f5171b6276c3562f17167f28322fb1dbbfc696" "be0a93110ce776fa2f1ab7cdc94ae3918ced4c57f365d994b4f5427b73f13e6e" "0917d7c62178351ead0f505ca97a4cef83b848d840701ccee24d8b2180efb920" "c728708eae31c8eec7a9d406e604bcb692f2727579fc154622b9c7a2a03fcbf6" "3b06158f1acc3f1602b2dc6f00c762e05219f600a296bbea2b02b2a10cc8e7f9" "6cf6b1d1bc1e0990b8236a7a3d22162722df470dfdd641f367a0ef1a66cb59af" "c40cd311cc4dac6a69a06cb58f626f41751378414f87660da8bb698e2035b653" "b1648b05c88763790f9ada18824bda2beb68744bedc280c3048194e874f1e2b1" "39c5fa26b66e6341dae664281ae9d951221ce15f82d1bb403307184b582d1ce5" "943c9fe92be754292152765052f554caf74e03a45596468108c71b9adfc526c2" "b58a22c0cf8a9fe905e306d9fac01a2ae1c742e3d0e8dcf63d789d539ccde0bc" "bf51e072aa61d3158147622e989fc8b719781daa1622304e9d4b9a77f8a04af6" "65734302cb6ca5d16191622c5767913e76f5da66d960c61ecfd4e9b091d9c398" "78d52aa5167b609a9163ea32bf8fb9e8304ae71e518bf20a6631d64a3bb405c4" "9273b34a1dddcf4b54a83e28751a37478e132f0d7a23eef6cf0a46e26fa20b35" "ac548cdf0d61acbc93f8bb6ea1eaec389de1466274414322dae6f47e6a96d774" "675fcf7e38164ca90e0583eaf131b442ecd07afb17abbe1c700c8ebc09469ea3" "c77a31867f444e1c82bacd22146cb2d781a471168305e1660558b2b54ec016b7" "01a269e63522c39b95bee8df829ae8633ea372fd1921487cd6ccac42b1bf1cb9" "36a309985a0f9ed1a0c3a69625802f87dee940767c9e200b89cdebdb737e5b29" default)))
 '(dtrt-indent-mode t nil (dtrt-indent))
 '(egg-enable-tooltip t)
 '(egg-git-command "git")
 '(fci-rule-color "#383838")
 '(fringe-mode (quote (0 . 1)) nil (fringe))
 '(global-hl-line-mode nil)
 '(indicate-empty-lines nil)
 '(magit-git-executable "git")
 '(message-send-mail-function (quote message-send-mail-with-sendmail))
 '(overflow-newline-into-fringe nil)
 '(package-selected-packages
   (quote
    (dtrt-indent blank-mode exec-path-from-shell yaml-mode markdown-mode rainbow-mode magit highlight-symbol ack)))
 '(safe-local-variable-values
   (quote
    ((eval when
           (fboundp
            (quote rainbow-mode))
           (rainbow-mode 1)))))
 '(send-mail-function (quote mailclient-send-it))
 '(sml/active-background-color "#E05A2B")
 '(sml/active-foreground-color "white")
 '(sml/inactive-background-color "gray38")
 '(sml/inactive-foreground-color "gray45")
 '(sml/show-client t)
 '(tab-stop-list
   (quote
    (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))))

(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-iso-lefttab] (lambda () (interactive) (other-window -1)))

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
  (setq indent-tabs-mode t)
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
(add-hook 'c-mode-common-hook 'auto-fill-mode)
; No extra indent in an extern block (#ifdef __cplusplus)
(add-hook 'c-mode-common-hook
          (lambda()
                 (c-set-offset 'inextern-lang 0)))

(setq-default buffer-file-coding-system 'dos)


; Color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;;Emacs.pane.menubar.* does not seem to work?
;(setq Emacs.pane.menubar.background 'darkGrey)
;Emacs.pane.menubar.foreground: black

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t nil)))
 '(mode-line ((t (:background "#E05A2B" :foreground "white" :box nil))))
 '(mode-line-highlight ((t nil)))
 '(mode-line-inactive ((t (:background "gray38" :foreground "gray45"))))
 '(sml/col-number ((t (:inherit sml/global))))
 '(sml/filename ((t (:inherit sml/global :foreground "white" :weight bold))))
 '(sml/global ((t (:foreground "gray89"))))
 '(sml/modified ((t (:inherit sml/global :foreground "royal blue" :inverse-video t :weight ultra-bold))))
 '(sml/prefix ((t (:inherit sml/global :foreground "light blue")))))

; Smart mode line
(require 'smart-mode-line)
(sml/setup)

(if (< emacs-major-version 24)
  (progn
    (require 'color-theme)
    (require 'color-theme-zenburn)
    (color-theme-zenburn)
    ;(color-theme-pok-wog)
    )
  (load-theme 'bisque-darker t)
)

;; no electric mode in c
(if (< emacs-major-version 25)
    (c-toggle-electric-state -1))

; indent the current line only if the cursor is at the beginning of the line
;(setq-default c-tab-always-indent nil)
;(setq-default c-indent-level 4)
;(setq-default tab-width 4)
;(setq-default indent-tabs-mode nil)
;(setq-default c-basic-offset 4)
;(setq-default c-basic-indent 4)
(setq-default truncate-lines t)
(setq-default transient-mark-mode nil)
; These commands I read about on the web, but they don't work?
;(highlight-tabs)
;(highlight-trailing-whitespace)

;(setq c-default-style "k&r")
(setq tab-width 4)
; indent C preprocessor macros together with the code.
(c-set-offset (quote cpp-macro) 0 nil)
;(setq indent-line-function 'insert-tab)
(setq asm-indent-level 4)
(c-set-offset 'innamespace 0)
(setq c-auto-align-backslashes nil)

(defconst eclipse-c-style
  '((c-basic-offset . 4)
    (indent-tabs-mode . t)
    (tab-width . 4)
    (c-comment-only-line-offset . (0 . 0))
    (c-offsets-alist . ((topmost-intro-cont    . +)
                        (statement-block-intro . +)
                        (knr-argdecl-intro     . 5)
                        (substatement-open     . +)
                        (substatement-label    . +)
                        (label                 . +)
                        (statement-case-open   . +)
                        (statement-cont        . +)
                        (arglist-intro  . c-lineup-arglist-intro-after-paren)
                        (arglist-close  . c-lineup-arglist)
                        (access-label   . 0)
                        (arglist-cont-nonempty . ++)
                        )))
  "Eclipse C Programming Style")
(c-add-style "Eclipse C" eclipse-c-style)
;(setq c-default-style "Eclipse C")

(defconst mira-c-style
  '((c-basic-offset . 4)
    (indent-tabs-mode . nil)
    (tab-width . 7)
    (c-comment-only-line-offset . (0 . 0))
    (c-lineup-C-comments . 0)
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
                        (access-label   . 0)
			(arglist-cont-nonempty . +)
                        )))
  "Mira C Programming Style")
(c-add-style "Mira C" mira-c-style)
(setq c-default-style "Mira C")

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


;; Refresh
(global-set-key (kbd "C-c R") '(lambda () (interactive) (revert-buffer nil t nil)))
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )
(global-set-key (kbd "C-c r") '(lambda () (interactive) (revert-all-buffers)))


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
;; (defvar column-marker-1-face ((t (:background "#4f4f4f"))))
;; (defvar column-marker-2-face ((t (:background "#5f5f5f"))))
;; (defvar column-marker-3-face ((t (:background "#8c5353"))))

;; Always longlines-mode and spell checking for text files
(add-hook 'text-mode-hook 'longlines-mode 'flyspell-mode)

;; Always can after enabling flyspell
(add-hook 'flyspell-mode-hook 'flyspell-buffer)

;; Ack as a replacement for grep
(global-set-key "\M-s" 'ack)
(require 'ack)
;; (add-to-list 'load-path "C:/Program/emacs-22.3/includes/full-ack")
;; (autoload 'ack-same "full-ack" nil t)
;; (autoload 'ack "full-ack" nil t)
;; (autoload 'ack-find-same-file "full-ack" nil t)
;; (autoload 'ack-find-file "full-ack" nil t)

;; Better ack-mode?
;;(load '"ack-mode/ack-mode.el")
;; install from ELPA instead!:
;; M-x package-install RET ack RET
;; coloring works there.

;; ANSI colors, first added for search results from ack. Need to call the
;; function automatically on ack buffer. Links still not working, so continue
;; calling ack with --group --no-color --no-heading
(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(add-hook 'ack-mode-hook 'display-ansi-colors)

;; Better buffer list functionality.
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Assembly" (mode . asm-mode))
               ("Programming" (or
                               (mode . c-mode)
                               (mode . perl-mode)
                               (mode . python-mode)
                               (mode . emacs-lisp-mode)))
               ("org" (filename . ".*\.org"))
               ("text" (or
                        (filename . ".*\.txt")
                        (filename . ".*\.log")))
               ("Emacs" (name . "^\\*.*\\*$"))))))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-switch-to-saved-filter-groups "default")))

(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Tags
;; Shell command: find . -type f \( -name '*.cpp' -o -name '*.[ch]pp' \) | etags -
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "cd %s && find . -type f \\( -name \'*.[ch]\' -o -name \'*.[ch]pp\' \\) | etags -" dir-name))
  )

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
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (require 'ipython)
;; (setq py-python-command-args '("-pylab" "-colors" "LightBG"))
;; (setq ipython-command "ipython")

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
  (beginning-of-defun)  ; leave mark at the old location
  (insert "/**
 * @brief
 * @param
 * @return
 */
")
  (word-search-backward "brief")
  (move-end-of-line nil))
(define-key global-map "\C-x\C-hf" 'insert-function-header)

(defun insert-prototype-header()
  "Insert a C prototype header here."
  (interactive)
  (insert "/**
 * @brief
 * @param
 * @return
 */
")
  (word-search-backward "brief")
  (move-end-of-line nil))
(define-key global-map "\C-x\C-hp" 'insert-prototype-header)

(defun insert-c-file-header()
  "Insert a C file header."
  (interactive)
  (insert "/*----------------------------------------------------------------------------
Copyright (c) 2013 LumenRadio AB
This code is the property of Lumenradio AB and may not be redistributed in any
form without prior written permission from LumenRadio AB.
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
Copyright (c) 2013 LumenRadio AB
This code is the property of LumenRadio AB and may not be redistributed in any
form without prior written permission from LumenRadio AB.
----------------------------------------------------------------------------*/

#ifndef _INCLUDED
#define _INCLUDED
#endif // _INCLUDED
"))


; Occur
;; Same as occur with default symbol at point, no need to press enter.
(defun occur-symbol-at-point ()
  (interactive)
  (let ((sym (thing-at-point 'symbol)))
    (funcall 'occur sym)))
(global-set-key (kbd "\C-co") 'occur-symbol-at-point)


; Find-tag
;; Same as find-tag, without the need to press enter.
(defun find-tag-at-point ()
  (interactive)
  (let ((sym (thing-at-point 'symbol)))
    (funcall 'find-tag sym)))
(global-set-key (kbd "C-.") 'find-tag-at-point)

;(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'ws-trim)
(setq ws-trim-level 1) ; 1 -> only modified lines are trimmed.
(setq ws-trim-method-hook '(ws-trim-trailing ws-trim-tabs))
(global-ws-trim-mode t)

(require 'copy)

(require 'highlight-symbol)
(global-set-key (kbd "C-c h") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c n") 'highlight-symbol-next)
(global-set-key (kbd "C-c p") 'highlight-symbol-prev)
(global-set-key (kbd "C-c H") 'highlight-symbol-remove-all)
;(global-set-key [(control meta f3)] 'highlight-symbol-query-replace)

;; Interface to git
(require 'egg)

;; To format git commit messages
(require 'git-commit)
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)

;; Mover buffers across windows
(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)


;; Start server to allow for emacsclient to use this.
;; Somehow, starting the server (emacs --daemon) from a terminal or Ubuntu's
;; startup applicactions does not seem to work for the emacs 25 I have.
(server-start)

;; Server now started by the daemon at my log in.
(put 'downcase-region 'disabled nil)


;; Fill newly created files with template content
(require 'defaultcontent)

;; UTF-8 as default (mostly for encoding swedish characters correctly)
(prefer-coding-system 'utf-8)

(setq-default fill-column 80)


(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; Don't convert _ and ^ unless surrounded by braces
(setq org-export-with-sub-superscripts '{})
(add-hook 'org-mode-hook 'auto-fill-mode)
(setq org-startup-indented t)
(setq org-ellipsis " \u25bc")

;;(require 'notmuch)

(setq mail-user-agent 'message-user-agent)
(setq user-mail-address "gauthier.ostervall@lumenradio.com"
      user-full-name "Gauthier Östervall")
(setq smtpmail-smtp-server "smtp.lumenradio.com") ; not tested
; Line below gives warning at startup, wront number of arguments?
;(message-send-mail-function 'message-smtpmail-send-it)

;; For visual-line-mode, to set a right margin
;; visual-wrap-column-set
(require 'visual)

(require 'google-c-style)

;; Find File
(setq cc-search-directories '("."
							  "../include" "../source"
                              "../inc" "../inc/*" "../../inc/*" "../../../inc/*"
                              "../../inc/*/*" "../../../inc/*/*/*"
                              "../src" "../src/*" "../../src/*" "../../../src/*"
                              "../../src/*/*" "../../../src/*/*/*"
                              "/usr/include" "/usr/local/include/*"))

(defun find-other-file-no-include ()
  (interactive)
  (ff-find-other-file nil t))
(global-set-key (kbd "M-o") 'find-other-file-no-include)

(defun find-other-file-no-include-other-window ()
  (interactive)
  (ff-find-other-file t t))
(global-set-key (kbd "M-O") 'find-other-file-no-include-other-window)

;; Zoom on all frame
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

;; key bindings for Mac
;;(when (eq system-type 'darwin) ;; mac specific settings
;;  (setq mac-option-modifier 'meta)
;;  (setq mac-command-modifier 'control)
;;  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
;;  )

;; robot framework major mode
(load "robot-mode.el")
(add-to-list 'auto-mode-alist '("\\.robot\\'" . robot-mode))

;; Import important environment variables from shell, for Mac OS
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("LANG" "LC_ALL"))
  (message "Initialized PATH and other variables from SHELL."))

;; Waiting for an answer on http://emacs.stackexchange.com/questions/31577/dir-local-el-misunderstanding
;; Doing this globally instead of specific to mira project.
(setq-default indent-tabs-mode nil)
(require 'dtrt-indent)
(dtrt-indent-mode t)

;; Display whitespace characters.
(global-set-key (kbd "C-c b") 'blank-mode)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
