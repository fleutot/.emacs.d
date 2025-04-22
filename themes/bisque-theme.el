;;; bisque-theme.el --- Based on:
;;; zenburn-theme.el --- A low contrast color theme for Emacs.

;; Copyright (C) 2011-2013 Bozhidar Batsov

;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: http://github.com/bbatsov/zenburn-emacs
;; Version: 1.7

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; A port of the popular Vim theme Zenburn for Emacs 24, built on top
;; of the new built-in theme support in Emacs 24.
;;
;;; Credits:
;;
;; Jani Nurminen created the original theme for vim on such this port
;; is based.

;;; Code:
(deftheme bisque "The bisque color theme, based on zenburn")

(let ((class '((class color) (min-colors 89)))
      ;; Zenburn palette
      ;; colors with +x are lighter, colors with -x are darker
      ;; #ac9a85 = (bisque3 + bisque4) / 2
      (bisque-fg "#ac9a85")
      (bisque-fg-1 "bisque4")
      (bisque-fg-2 "#555549")
      (bisque-fg+1 "#ccab95")
      (bisque-bg-1 "#2b2b2b")
      (bisque-bg-05 "#383838")
      (bisque-bg "#45423f")
      (bisque-bg+05 "#484848")
      (bisque-bg+1 "#4f4f4f")
      (bisque-bg+2 "#5f5f5f")
      (bisque-bg+3 "#6f6f6f")
      (bisque-red+2 "#ff8383")
      (bisque-red+1 "#dca3a3")
      (bisque-red "#cc9393")
      (bisque-red-1 "#bc8383")
      (bisque-red-2 "#ac7373")
      (bisque-red-3 "#9c6363")
      (bisque-red-4 "#8c5353")
      (bisque-red-5 "#7c4343")
      (bisque-orange "#dfaf8f")
      (bisque-orange-1 "#cf9f7f")
      (bisque-orange-4 "#674f3f")
      (bisque-yellow+1 "#e0d370")
      (bisque-yellow "#f0dfaf")
      (bisque-yellow-1 "#e0cf9f")
      (bisque-yellow-2 "#d0bf8f")
      (bisque-green-4 "#273727")
      (bisque-green-2 "#4f6f4f")
      (bisque-green-1 "#688068")
      (bisque-green "#7f9f7f")
      (bisque-green+1 "#8fb28f")
      (bisque-green+2 "#9fc59f")
      (bisque-green+3 "#afd8af")
      (bisque-green+4 "#bfebbf")
      (bisque-cyan "#93e0e3")
      (bisque-blue+1 "#94bff3")
      (bisque-blue "#8cd0d3")
      (bisque-blue-1 "#7cb8bb")
      (bisque-blue-2 "#6ca0a3")
      (bisque-blue-3 "#5c888b")
      (bisque-blue-4 "#4c7073")
      (bisque-blue-5 "#366060")
      (bisque-magenta "#dc8cc3")
      (bisque-magenta-1 "#c878b0")
      (bisque-magenta-2 "#b868a0")
      )
  (custom-theme-set-faces
   'bisque
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,bisque-yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,bisque-yellow-2 :underline t :weight normal))))

   ;;; basic coloring
   `(default ((t (:foreground ,bisque-fg :background ,bisque-bg))))
   `(cursor ((t (:foreground ,bisque-fg :background ,bisque-yellow+1))))
   `(escape-glyph ((t (:foreground ,bisque-yellow :bold t))))
   `(fringe ((t (:foreground ,bisque-yellow+1 :background ,bisque-bg))))
   `(header-line ((t (:foreground ,bisque-yellow
                                  :background ,bisque-bg-1))))
                                  ;;:box (:line-width -1 :style released-button)))))
   `(highlight ((t (:background ,bisque-bg-05))))
   `(shadow ((t (:foreground ,bisque-bg+05))))

   ;;; ANSI
   `(ansi-color-red ((t (:foreground ,bisque-red-3))))
   `(ansi-color-green ((t (:foreground ,bisque-green-1))))
   `(ansi-color-yellow ((t (:foreground ,bisque-yellow-2))))
   `(ansi-color-blue ((t (:foreground ,bisque-blue-3))))
   `(ansi-color-magenta ((t (:foreground ,bisque-magenta-2))))
   `(ansi-color-cyan ((t (:foreground ,bisque-cyan))))
   `(ansi-color-bold ((t (:weight bold))))

   ;;; compilation
   `(compilation-column-face ((t (:foreground ,bisque-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,bisque-green))))
   `(compilation-error-face ((t (:foreground ,bisque-red-1 :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,bisque-fg))))
   `(compilation-info-face ((t (:foreground ,bisque-blue))))
   `(compilation-info ((t (:foreground ,bisque-green+4 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,bisque-green))))
   `(compilation-line-face ((t (:foreground ,bisque-yellow))))
   `(compilation-line-number ((t (:foreground ,bisque-yellow))))
   `(compilation-message-face ((t (:foreground ,bisque-blue))))
   `(compilation-warning-face ((t (:foreground ,bisque-orange :weight bold :underline t))))

   ;;; dired
   `(dired-ignored ((t (:foreground ,bisque-fg-2))))

   ;;; grep
   `(grep-context-face ((t (:foreground ,bisque-fg))))
   `(grep-error-face ((t (:foreground ,bisque-red-1 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,bisque-blue))))
   `(grep-match-face ((t (:foreground ,bisque-orange :weight bold))))
   `(match ((t (:background ,bisque-bg-1 :foreground ,bisque-orange :weight bold))))

   ;; faces used by isearch
   `(isearch ((t (:foreground ,bisque-bg :background ,bisque-orange))))
   `(isearch-fail ((t (:foreground ,bisque-bg :background ,bisque-red))))
   `(lazy-highlight ((t (:foreground ,bisque-bg :background ,bisque-yellow-2))))

   `(menu ((t (:foreground ,bisque-fg :background ,bisque-bg))))
   `(minibuffer-prompt ((t (:foreground ,bisque-green :background ,bisque-bg))))
   `(mode-line
     ((,class (:foreground ,bisque-green+4
                           :background ,bisque-bg-1))
                           ;;:box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,bisque-yellow :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,bisque-green-1
                      :background ,bisque-bg-05))))
                      ;;:box (:line-width -1 :style released-button)))))
   `(region ((,class (:background ,bisque-bg-1))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,bisque-bg+2))))
   `(trailing-whitespace ((t (:background ,bisque-red+2))))
   `(vertical-border ((t (:foreground ,bisque-fg))))

   ;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,bisque-cyan))))
   `(font-lock-comment-face ((t (:foreground ,bisque-green))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,bisque-green))))
   `(font-lock-constant-face ((t (:foreground ,bisque-green+2))))
   `(font-lock-doc-face ((t (:foreground ,bisque-green+1))))
   `(font-lock-doc-string-face ((t (:foreground ,bisque-blue-2))))
   `(font-lock-function-name-face ((t (:foreground ,bisque-blue))))
   `(font-lock-keyword-face ((t (:foreground ,bisque-yellow :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,bisque-fg))))
   `(font-lock-preprocessor-face ((t (:foreground ,bisque-blue+1))))
   `(font-lock-string-face ((t (:foreground ,bisque-red))))
   `(font-lock-type-face ((t (:foreground ,bisque-blue-1))))
   `(font-lock-variable-name-face ((t (:foreground ,bisque-orange))))
   `(font-lock-warning-face ((t (:foreground ,bisque-yellow-2 :weight bold))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))

   ;;; newsticker
   `(newsticker-date-face ((t (:foreground ,bisque-fg))))
   `(newsticker-default-face ((t (:foreground ,bisque-fg))))
   `(newsticker-enclosure-face ((t (:foreground ,bisque-green+3))))
   `(newsticker-extra-face ((t (:foreground ,bisque-bg+2 :height 0.8))))
   `(newsticker-feed-face ((t (:foreground ,bisque-fg))))
   `(newsticker-immortal-item-face ((t (:foreground ,bisque-green))))
   `(newsticker-new-item-face ((t (:foreground ,bisque-blue))))
   `(newsticker-obsolete-item-face ((t (:foreground ,bisque-red))))
   `(newsticker-old-item-face ((t (:foreground ,bisque-bg+3))))
   `(newsticker-statistics-face ((t (:foreground ,bisque-fg))))
   `(newsticker-treeview-face ((t (:foreground ,bisque-fg))))
   `(newsticker-treeview-immortal-face ((t (:foreground ,bisque-green))))
   `(newsticker-treeview-listwindow-face ((t (:foreground ,bisque-fg))))
   `(newsticker-treeview-new-face ((t (:foreground ,bisque-blue :weight bold))))
   `(newsticker-treeview-obsolete-face ((t (:foreground ,bisque-red))))
   `(newsticker-treeview-old-face ((t (:foreground ,bisque-bg+3))))
   `(newsticker-treeview-selection-face ((t (:foreground ,bisque-yellow))))

   ;;; external

   ;; full-ack
   `(ack-separator ((t (:foreground ,bisque-fg))))
   `(ack-file ((t (:foreground ,bisque-blue))))
   `(ack-line ((t (:foreground ,bisque-yellow))))
   `(ack-match ((t (:foreground ,bisque-orange :background ,bisque-bg-1 :weight bold))))

   ;; auctex
   `(font-latex-bold ((t (:inherit bold))))
   `(font-latex-warning ((t (:inherit font-lock-warning))))
   `(font-latex-sedate ((t (:foreground ,bisque-yellow :weight bold ))))
   `(font-latex-title-4 ((t (:inherit variable-pitch :weight bold))))

   ;; auto-complete
   `(ac-candidate-face ((t (:background ,bisque-bg+3 :foreground "black"))))
   `(ac-selection-face ((t (:background ,bisque-blue-4 :foreground ,bisque-fg))))
   `(popup-tip-face ((t (:background ,bisque-yellow-2 :foreground "black"))))
   `(popup-scroll-bar-foreground-face ((t (:background ,bisque-blue-5))))
   `(popup-scroll-bar-background-face ((t (:background ,bisque-bg-1))))
   `(popup-isearch-match ((t (:background ,bisque-bg :foreground ,bisque-fg))))

   ;; clojure-test-mode
   `(clojure-test-failure-face ((t (:foreground ,bisque-orange :weight bold :underline t))))
   `(clojure-test-error-face ((t (:foreground ,bisque-red :weight bold :underline t))))
   `(clojure-test-success-face ((t (:foreground ,bisque-green+1 :weight bold :underline t))))

   ;; diff
   `(diff-added ((,class (:foreground ,bisque-green+4))
                 (t (:foreground ,bisque-green-1))))
   `(diff-changed ((t (:foreground ,bisque-yellow))))
   `(diff-removed ((,class (:foreground ,bisque-red))
                   (t (:foreground ,bisque-red-3))))
   `(diff-header ((,class (:background ,bisque-bg+2))
                  (t (:background ,bisque-fg :foreground ,bisque-bg))))
   `(diff-file-header
     ((,class (:background ,bisque-bg+2 :foreground ,bisque-fg :bold t))
      (t (:background ,bisque-fg :foreground ,bisque-bg :bold t))))

   ;; ert
   `(ert-test-result-expected ((t (:foreground ,bisque-green+4 :background ,bisque-bg))))
   `(ert-test-result-unexpected ((t (:foreground ,bisque-red :background ,bisque-bg))))

   ;; eshell
   `(eshell-prompt ((t (:foreground ,bisque-yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,bisque-red-1 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment))))
   `(eshell-ls-directory ((t (:foreground ,bisque-blue+1 :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,bisque-red+1 :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,bisque-fg))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning))))
   `(eshell-ls-product ((t (:inherit font-lock-doc))))
   `(eshell-ls-special ((t (:foreground ,bisque-yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,bisque-cyan :weight bold))))

   ;; flycheck
   `(flycheck-error ((t (:background ,bisque-red-4 :weight bold :underline t))))
   `(flycheck-warning ((t (:background ,bisque-orange-4 :weight
                                       bold))))
   `(flycheck-info ((t (:background ,bisque-green-4 :weight bold))))
   `(flycheck-posframe-error-face ((t (:foreground ,bisque-red-1))))
   `(flycheck-posframe-warning-face ((t (:foreground ,bisque-orange))))
   `(flycheck-posframe-info-face ((t (:foreground ,bisque-green))))
   `(flycheck-posframe-background-face ((t (:background ,bisque-bg-05))))
   `(flycheck-posframe-border-face ((t (:foreground ,bisque-bg+1))))


   ;; flymake
   `(flymake-errline ((t (:foreground ,bisque-red-1 :weight bold :underline t))))
   `(flymake-warnline ((t (:foreground ,bisque-orange :weight bold :underline t))))

   ;; flyspell
   `(flyspell-duplicate ((t (:foreground ,bisque-orange :weight bold :underline t))))
   `(flyspell-incorrect ((t (:foreground ,bisque-red-1 :weight bold :underline t))))

   ;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,bisque-blue :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning))))
   `(erc-default-face ((t (:foreground ,bisque-fg))))
   `(erc-direct-msg-face ((t (:inherit erc-default))))
   `(erc-error-face ((t (:inherit font-lock-warning))))
   `(erc-fool-face ((t (:inherit erc-default))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,bisque-yellow))))
   `(erc-keyword-face ((t (:foreground ,bisque-blue :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,bisque-yellow :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,bisque-red :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default))))
   `(erc-notice-face ((t (:foreground ,bisque-green))))
   `(erc-pal-face ((t (:foreground ,bisque-orange :weight bold))))
   `(erc-prompt-face ((t (:foreground ,bisque-orange :background ,bisque-bg :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,bisque-green+1))))
   `(erc-underline-face ((t (:underline t))))

   ;; git
   `(git-commit-nonempty-second-line ((,class (:foreground ,bisque-red :weight bold :inverse-video t))))
   `(git-commit-overlong-summary ((,class (:foreground ,bisque-orange :inverse-video t))))

   ;; git-gutter
   `(git-gutter:added ((,class (:foreground ,bisque-green :weight bold :inverse-video t))))
   `(git-gutter:deleted ((,class (:foreground ,bisque-red :weight bold :inverse-video t))))
   `(git-gutter:modified ((,class (:foreground ,bisque-magenta :weight bold :inverse-video t))))

   ;; gnus
   `(gnus-group-mail-1 ((t (:bold t :inherit gnus-group-mail-1-empty))))
   `(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
   `(gnus-group-mail-2 ((t (:bold t :inherit gnus-group-mail-2-empty))))
   `(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
   `(gnus-group-mail-3 ((t (:bold t :inherit gnus-group-mail-3-empty))))
   `(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
   `(gnus-group-mail-4 ((t (:bold t :inherit gnus-group-mail-4-empty))))
   `(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
   `(gnus-group-mail-5 ((t (:bold t :inherit gnus-group-mail-5-empty))))
   `(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
   `(gnus-group-mail-6 ((t (:bold t :inherit gnus-group-mail-6-empty))))
   `(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
   `(gnus-group-mail-low ((t (:bold t :inherit gnus-group-mail-low-empty))))
   `(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))
   `(gnus-group-news-1 ((t (:bold t :inherit gnus-group-news-1-empty))))
   `(gnus-group-news-2 ((t (:bold t :inherit gnus-group-news-2-empty))))
   `(gnus-group-news-3 ((t (:bold t :inherit gnus-group-news-3-empty))))
   `(gnus-group-news-4 ((t (:bold t :inherit gnus-group-news-4-empty))))
   `(gnus-group-news-5 ((t (:bold t :inherit gnus-group-news-5-empty))))
   `(gnus-group-news-6 ((t (:bold t :inherit gnus-group-news-6-empty))))
   `(gnus-group-news-low ((t (:bold t :inherit gnus-group-news-low-empty))))
   `(gnus-header-content ((t (:inherit message-header-other))))
   `(gnus-header-from ((t (:inherit message-header-from))))
   `(gnus-header-name ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups ((t (:inherit message-header-other))))
   `(gnus-header-subject ((t (:inherit message-header-subject))))
   `(gnus-summary-cancelled ((t (:foreground ,bisque-orange))))
   `(gnus-summary-high-ancient ((t (:foreground ,bisque-blue))))
   `(gnus-summary-high-read ((t (:foreground ,bisque-green :weight bold))))
   `(gnus-summary-high-ticked ((t (:foreground ,bisque-orange :weight bold))))
   `(gnus-summary-high-unread ((t (:foreground ,bisque-fg :weight bold))))
   `(gnus-summary-low-ancient ((t (:foreground ,bisque-blue))))
   `(gnus-summary-low-read ((t (:foreground ,bisque-green))))
   `(gnus-summary-low-ticked ((t (:foreground ,bisque-orange :weight bold))))
   `(gnus-summary-low-unread ((t (:foreground ,bisque-fg))))
   `(gnus-summary-normal-ancient ((t (:foreground ,bisque-blue))))
   `(gnus-summary-normal-read ((t (:foreground ,bisque-green))))
   `(gnus-summary-normal-ticked ((t (:foreground ,bisque-orange :weight bold))))
   `(gnus-summary-normal-unread ((t (:foreground ,bisque-fg))))
   `(gnus-summary-selected ((t (:foreground ,bisque-yellow :weight bold))))
   `(gnus-cite-1 ((t (:foreground ,bisque-blue))))
   `(gnus-cite-10 ((t (:foreground ,bisque-yellow-1))))
   `(gnus-cite-11 ((t (:foreground ,bisque-yellow))))
   `(gnus-cite-2 ((t (:foreground ,bisque-blue-1))))
   `(gnus-cite-3 ((t (:foreground ,bisque-blue-2))))
   `(gnus-cite-4 ((t (:foreground ,bisque-green+2))))
   `(gnus-cite-5 ((t (:foreground ,bisque-green+1))))
   `(gnus-cite-6 ((t (:foreground ,bisque-green))))
   `(gnus-cite-7 ((t (:foreground ,bisque-red))))
   `(gnus-cite-8 ((t (:foreground ,bisque-red-1))))
   `(gnus-cite-9 ((t (:foreground ,bisque-red-2))))
   `(gnus-group-news-1-empty ((t (:foreground ,bisque-yellow))))
   `(gnus-group-news-2-empty ((t (:foreground ,bisque-green+3))))
   `(gnus-group-news-3-empty ((t (:foreground ,bisque-green+1))))
   `(gnus-group-news-4-empty ((t (:foreground ,bisque-blue-2))))
   `(gnus-group-news-5-empty ((t (:foreground ,bisque-blue-3))))
   `(gnus-group-news-6-empty ((t (:foreground ,bisque-bg+2))))
   `(gnus-group-news-low-empty ((t (:foreground ,bisque-bg+2))))
   `(gnus-signature ((t (:foreground ,bisque-yellow))))
   `(gnus-x ((t (:background ,bisque-fg :foreground ,bisque-bg))))

   ;; helm
   `(helm-header
     ((t (:foreground ,bisque-green
                      :background ,bisque-bg
                      :underline nil
                      :box nil
                      :extend t))))
   `(helm-source-header
     ((t (:foreground ,bisque-yellow
                      :background ,bisque-bg-1
                      :underline nil
                      :weight bold
                      :box nil ;; (:line-width -1 :style released-button)
                      :extend t))))
   `(helm-selection ((t (:background ,bisque-bg+1 :underline nil))))
   `(helm-selection-line ((t (:background ,bisque-bg+1))))
   `(helm-visible-mark ((t (:foreground ,bisque-bg :background ,bisque-yellow-2))))
   `(helm-candidate-number ((t (:foreground ,bisque-green+4 :background ,bisque-bg-1))))
   `(helm-separator ((t (:foreground ,bisque-red+2 :background ,bisque-bg :extend t))))
   `(helm-time-zone-current ((t (:foreground ,bisque-green+2 :background ,bisque-bg))))
   `(helm-time-zone-home ((t (:foreground ,bisque-red :background ,bisque-bg))))
   `(helm-bookmark-addressbook ((t (:foreground ,bisque-orange :background ,bisque-bg))))
   `(helm-bookmark-directory ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus ((t (:foreground ,bisque-magenta :background ,bisque-bg))))
   `(helm-bookmark-info ((t (:foreground ,bisque-green+2 :background ,bisque-bg))))
   `(helm-bookmark-man ((t (:foreground ,bisque-yellow :background ,bisque-bg))))
   `(helm-bookmark-w3m ((t (:foreground ,bisque-magenta :background ,bisque-bg))))
   `(helm-buffer-not-saved ((t (:foreground ,bisque-red :background ,bisque-bg))))
   `(helm-buffer-process ((t (:foreground ,bisque-cyan :background ,bisque-bg))))
   `(helm-buffer-saved-out ((t (:foreground ,bisque-fg :background ,bisque-bg))))
   `(helm-buffer-size ((t (:foreground ,bisque-fg-1 :background ,bisque-bg))))
   `(helm-ff-directory ((t (:foreground ,bisque-cyan :background ,bisque-bg :weight bold))))
   `(helm-ff-file ((t (:foreground ,bisque-fg :background ,bisque-bg :weight normal))))
   `(helm-ff-executable ((t (:foreground ,bisque-green+2 :background ,bisque-bg :weight normal))))
   `(helm-ff-invalid-symlink ((t (:foreground ,bisque-red :background ,bisque-bg :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,bisque-yellow :background ,bisque-bg :weight bold))))
   `(helm-ff-prefix ((t (:foreground ,bisque-bg :background ,bisque-yellow :weight normal))))
   `(helm-grep-cmd-line ((t (:foreground ,bisque-cyan :background ,bisque-bg))))
   `(helm-grep-file ((t (:foreground ,bisque-fg :background ,bisque-bg))))
   `(helm-grep-finish ((t (:foreground ,bisque-green+2 :background ,bisque-bg))))
   `(helm-grep-lineno ((t (:foreground ,bisque-fg-1 :background ,bisque-bg))))
   `(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((t (:foreground ,bisque-red :background ,bisque-bg))))
   `(helm-match ((t (:foreground ,bisque-orange :background ,bisque-bg-1 :weight bold))))
   `(helm-moccur-buffer ((t (:foreground ,bisque-cyan :background ,bisque-bg))))
   `(helm-mu-contacts-address-face ((t (:foreground ,bisque-fg-1 :background ,bisque-bg))))
   `(helm-mu-contacts-name-face ((t (:foreground ,bisque-fg :background ,bisque-bg))))
;;;;; helm-lxc
   `(helm-lxc-face-frozen ((t (:foreground ,bisque-blue :background ,bisque-bg))))
   `(helm-lxc-face-running ((t (:foreground ,bisque-green :background ,bisque-bg))))
   `(helm-lxc-face-stopped ((t (:foreground ,bisque-red :background ,bisque-bg))))
;;;;; helm-swoop
   `(helm-swoop-target-line-face ((t (:foreground ,bisque-fg :background ,bisque-bg+1))))
   `(helm-swoop-target-word-face ((t (:foreground ,bisque-yellow :background
                                                  ,bisque-bg+2 :weight bold))))

   ;; highlight-symbol
   `(highlight-symbol-face ((t (:background ,bisque-bg-1))))

   ;; hl-line-mode
   `(hl-line-face ((,class (:background ,bisque-bg-05))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,bisque-bg-05)) ; old emacsen
              (t :weight bold)))

   ;; hl-sexp
   `(hl-sexp-face ((,class (:background ,bisque-bg+1))
                   (t :weight bold)))

   ;; ido-mode
   `(ido-first-match ((t (:foreground ,bisque-yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,bisque-orange :weight bold))))
   `(ido-subdir ((t (:foreground ,bisque-yellow))))

   ;; js2-mode
   `(js2-warning-face ((t (:underline ,bisque-orange))))
   `(js2-error-face ((t (:foreground ,bisque-red :weight bold))))
   `(js2-jsdoc-tag-face ((t (:foreground ,bisque-green-1))))
   `(js2-jsdoc-type-face ((t (:foreground ,bisque-green+2))))
   `(js2-jsdoc-value-face ((t (:foreground ,bisque-green+3))))
   `(js2-function-param-face ((t (:foreground, bisque-green+3))))
   `(js2-external-variable-face ((t (:foreground ,bisque-orange))))

   ;; jabber-mode
   `(jabber-roster-user-away ((t (:foreground ,bisque-green+2))))
   `(jabber-roster-user-online ((t (:foreground ,bisque-blue-1))))
   `(jabber-roster-user-dnd ((t (:foreground ,bisque-red+1))))
   `(jabber-rare-time-face ((t (:foreground ,bisque-green+1))))
   `(jabber-chat-prompt-local ((t (:foreground ,bisque-blue-1))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,bisque-red+1))))
   `(jabber-activity-face((t (:foreground ,bisque-red+1))))
   `(jabber-activity-personal-face ((t (:foreground ,bisque-blue+1))))
   `(jabber-title-small ((t (:height 1.1 :weight bold))))
   `(jabber-title-medium ((t (:height 1.2 :weight bold))))
   `(jabber-title-large ((t (:height 1.3 :weight bold))))

   ;; linum-mode
   `(linum ((t (:foreground ,bisque-green+2 :background ,bisque-bg))))

   ;; magit
   `(magit-section-title ((t (:foreground ,bisque-yellow :weight bold))))
   `(magit-branch ((t (:foreground ,bisque-orange :weight bold))))
   `(magit-item-highlight ((t (:background ,bisque-bg+1))))
   ;;; headings and diffs
   `(magit-section-highlight           ((t (:background ,bisque-bg+05))))
   `(magit-section-heading             ((t (:foreground ,bisque-yellow+1 :weight bold))))
   `(magit-section-heading-selection   ((t (:foreground ,bisque-orange :weight bold))))
   `(magit-diff-file-heading           ((t (:foreground ,bisque-bg :background ,bisque-blue-3  :weight bold))))
   `(magit-diff-file-heading-highlight ((t (:foreground, bisque-bg :background ,bisque-blue-2  :weight bold))))
   `(magit-diff-file-heading-selection ((t (:background ,bisque-bg+05
                                                        :foreground ,bisque-orange :weight bold))))
   `(magit-diff-hunk-heading           ((t (:background ,bisque-bg+1))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,bisque-bg+2 :foreground ,bisque-fg+1))))
   `(magit-diff-hunk-heading-selection ((t (:background ,bisque-bg+2
                                                        :foreground ,bisque-orange))))
   `(magit-diff-lines-heading          ((t (:background ,bisque-orange
                                                        :foreground ,bisque-bg+2))))
   `(magit-diff-context                ((t (:foreground ,bisque-fg))))
   `(magit-diff-context-highlight      ((t (:background ,bisque-bg
                                                        :foreground ,bisque-fg))))
   `(magit-diff-added      ((t (:foreground ,bisque-green))))
   `(magit-diff-added-highlight      ((t (:foreground ,bisque-green :background ,bisque-bg))))
   `(magit-diff-removed      ((t (:foreground ,bisque-red-1))))
   `(magit-diff-removed-highlight      ((t (:foreground ,bisque-red-1 :background ,bisque-bg))))

   `(magit-diffstat-added   ((t (:foreground ,bisque-green))))
   `(magit-diffstat-removed ((t (:foreground ,bisque-red-1))))
   ;;; popup
   `(magit-popup-heading             ((t (:foreground ,bisque-yellow  :weight bold))))
   `(magit-popup-key                 ((t (:foreground ,bisque-blue    :weight bold))))
   `(magit-popup-argument            ((t (:foreground ,bisque-green   :weight bold))))
   `(magit-popup-disabled-argument   ((t (:foreground ,bisque-fg-1    :weight normal))))
   `(magit-popup-option-value        ((t (:foreground ,bisque-blue-2  :weight bold))))
   ;;; process
   `(magit-process-ok    ((t (:foreground ,bisque-green  :weight bold))))
   `(magit-process-ng    ((t (:foreground ,bisque-red    :weight bold))))
   ;;; log
   `(magit-log-author    ((t (:foreground ,bisque-orange-1))))
   `(magit-log-date      ((t (:foreground ,bisque-fg-1))))
   `(magit-log-graph     ((t (:foreground ,bisque-fg+1))))
   ;;; sequence
   `(magit-sequence-pick ((t (:foreground ,bisque-yellow-2))))
   `(magit-sequence-stop ((t (:foreground ,bisque-green))))
   `(magit-sequence-part ((t (:foreground ,bisque-yellow))))
   `(magit-sequence-head ((t (:foreground ,bisque-blue))))
   `(magit-sequence-drop ((t (:foreground ,bisque-red))))
   `(magit-sequence-done ((t (:foreground ,bisque-fg-1))))
   `(magit-sequence-onto ((t (:foreground ,bisque-fg-1))))
   ;;; bisect
   `(magit-bisect-good ((t (:foreground ,bisque-green))))
   `(magit-bisect-skip ((t (:foreground ,bisque-yellow))))
   `(magit-bisect-bad  ((t (:foreground ,bisque-red))))
   ;;; blame
   `(magit-blame-heading ((t (:background ,bisque-bg-1 :foreground ,bisque-blue-2))))
   `(magit-blame-hash    ((t (:background ,bisque-bg-1 :foreground ,bisque-blue-2))))
   `(magit-blame-name    ((t (:background ,bisque-bg-1 :foreground ,bisque-orange))))
   `(magit-blame-date    ((t (:background ,bisque-bg-1 :foreground ,bisque-orange))))
   `(magit-blame-summary ((t (:background ,bisque-bg-1 :foreground ,bisque-blue-2
                                          :weight bold))))
   ;;; references etc
   `(magit-dimmed         ((t (:foreground ,bisque-bg+3))))
   `(magit-hash           ((t (:foreground ,bisque-bg+3))))
   `(magit-tag            ((t (:foreground ,bisque-orange :weight bold))))
   `(magit-branch-remote  ((t (:foreground ,bisque-green  :weight bold))))
   `(magit-branch-local   ((t (:foreground ,bisque-blue   :weight bold))))
   `(magit-branch-current ((t (:foreground ,bisque-blue   :weight bold :box t))))
   `(magit-head           ((t (:foreground ,bisque-blue   :weight bold))))
   `(magit-refname        ((t (:background ,bisque-bg+2 :foreground ,bisque-fg :weight bold))))
   `(magit-refname-stash  ((t (:background ,bisque-bg+2 :foreground ,bisque-fg :weight bold))))
   `(magit-refname-wip    ((t (:background ,bisque-bg+2 :foreground ,bisque-fg :weight bold))))
   `(magit-signature-good      ((t (:foreground ,bisque-green))))
   `(magit-signature-bad       ((t (:foreground ,bisque-red))))
   `(magit-signature-untrusted ((t (:foreground ,bisque-yellow))))
   `(magit-signature-expired   ((t (:foreground ,bisque-orange))))
   `(magit-signature-revoked   ((t (:foreground ,bisque-magenta))))
   '(magit-signature-error     ((t (:inherit    magit-signature-bad))))
   `(magit-cherry-unmatched    ((t (:foreground ,bisque-cyan))))
   `(magit-cherry-equivalent   ((t (:foreground ,bisque-magenta))))
   `(magit-reflog-commit       ((t (:foreground ,bisque-green))))
   `(magit-reflog-amend        ((t (:foreground ,bisque-magenta))))
   `(magit-reflog-merge        ((t (:foreground ,bisque-green))))
   `(magit-reflog-checkout     ((t (:foreground ,bisque-blue))))
   `(magit-reflog-reset        ((t (:foreground ,bisque-red))))
   `(magit-reflog-rebase       ((t (:foreground ,bisque-magenta))))
   `(magit-reflog-cherry-pick  ((t (:foreground ,bisque-green))))
   `(magit-reflog-remote       ((t (:foreground ,bisque-cyan))))
   `(magit-reflog-other        ((t (:foreground ,bisque-cyan))))

   `(markdown-header-face-1    ((t (:foreground ,bisque-blue))))
   `(markdown-header-face-2    ((t (:foreground ,bisque-blue-1))))
   `(markdown-header-face-3    ((t (:foreground ,bisque-blue-2))))
   `(markdown-header-face-4    ((t (:foreground ,bisque-blue-3))))
   `(markdown-header-face-5    ((t (:foreground ,bisque-blue-4))))
   `(markdown-header-face-6    ((t (:foreground ,bisque-blue-5))))
   `(markdown-inline-code-face ((t (:foreground ,bisque-magenta-1))))
   `(markdown-markup-face      ((t (:foreground ,bisque-fg-2))))
   `(markdown-pre-face         ((t (:foreground ,bisque-magenta-1))))

   ;; smerge
   `(smerge-refined-added      ((t (:background ,bisque-green-2))))
   `(smerge-refined-removed    ((t (:background ,bisque-red-5))))

   ;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment))))
   `(message-header-name ((t (:foreground ,bisque-green+1))))
   `(message-header-other ((t (:foreground ,bisque-green))))
   `(message-header-to ((t (:foreground ,bisque-yellow :weight bold))))
   `(message-header-from ((t (:foreground ,bisque-yellow :weight bold))))
   `(message-header-cc ((t (:foreground ,bisque-yellow :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,bisque-yellow :weight bold))))
   `(message-header-subject ((t (:foreground ,bisque-orange :weight bold))))
   `(message-header-xheader ((t (:foreground ,bisque-green))))
   `(message-mml ((t (:foreground ,bisque-yellow :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment))))

   ;; mew
   `(mew-face-header-subject ((t (:foreground ,bisque-orange))))
   `(mew-face-header-from ((t (:foreground ,bisque-yellow))))
   `(mew-face-header-date ((t (:foreground ,bisque-green))))
   `(mew-face-header-to ((t (:foreground ,bisque-red))))
   `(mew-face-header-key ((t (:foreground ,bisque-green))))
   `(mew-face-header-private ((t (:foreground ,bisque-green))))
   `(mew-face-header-important ((t (:foreground ,bisque-blue))))
   `(mew-face-header-marginal ((t (:foreground ,bisque-fg :weight bold))))
   `(mew-face-header-warning ((t (:foreground ,bisque-red))))
   `(mew-face-header-xmew ((t (:foreground ,bisque-green))))
   `(mew-face-header-xmew-bad ((t (:foreground ,bisque-red))))
   `(mew-face-body-url ((t (:foreground ,bisque-orange))))
   `(mew-face-body-comment ((t (:foreground ,bisque-fg :slant italic))))
   `(mew-face-body-cite1 ((t (:foreground ,bisque-green))))
   `(mew-face-body-cite2 ((t (:foreground ,bisque-blue))))
   `(mew-face-body-cite3 ((t (:foreground ,bisque-orange))))
   `(mew-face-body-cite4 ((t (:foreground ,bisque-yellow))))
   `(mew-face-body-cite5 ((t (:foreground ,bisque-red))))
   `(mew-face-mark-review ((t (:foreground ,bisque-blue))))
   `(mew-face-mark-escape ((t (:foreground ,bisque-green))))
   `(mew-face-mark-delete ((t (:foreground ,bisque-red))))
   `(mew-face-mark-unlink ((t (:foreground ,bisque-yellow))))
   `(mew-face-mark-refile ((t (:foreground ,bisque-green))))
   `(mew-face-mark-unread ((t (:foreground ,bisque-red-2))))
   `(mew-face-eof-message ((t (:foreground ,bisque-green))))
   `(mew-face-eof-part ((t (:foreground ,bisque-yellow))))

   ;; mic-paren
   `(paren-face-match ((t (:foreground ,bisque-cyan :background ,bisque-bg :weight bold))))
   `(paren-face-mismatch ((t (:foreground ,bisque-bg :background ,bisque-magenta :weight bold))))
   `(paren-face-no-match ((t (:foreground ,bisque-bg :background ,bisque-red :weight bold))))

   ;; nav
   `(nav-face-heading ((t (:foreground ,bisque-yellow))))
   `(nav-face-button-num ((t (:foreground ,bisque-cyan))))
   `(nav-face-dir ((t (:foreground ,bisque-green))))
   `(nav-face-hdir ((t (:foreground ,bisque-red))))
   `(nav-face-file ((t (:foreground ,bisque-fg))))
   `(nav-face-hfile ((t (:foreground ,bisque-red-4))))

   ;; mu4e
   `(mu4e-cited-1-face ((t (:foreground ,bisque-blue    :slant italic))))
   `(mu4e-cited-2-face ((t (:foreground ,bisque-green+2 :slant italic))))
   `(mu4e-cited-3-face ((t (:foreground ,bisque-blue-2  :slant italic))))
   `(mu4e-cited-4-face ((t (:foreground ,bisque-green   :slant italic))))
   `(mu4e-cited-5-face ((t (:foreground ,bisque-blue-4  :slant italic))))
   `(mu4e-cited-6-face ((t (:foreground ,bisque-green-1 :slant italic))))
   `(mu4e-cited-7-face ((t (:foreground ,bisque-blue    :slant italic))))
   `(mu4e-replied-face ((t (:foreground ,bisque-bg+3))))
   `(mu4e-trashed-face ((t (:foreground ,bisque-bg+3 :strike-through t))))

   ;; mumamo
   `(mumamo-background-chunk-major ((t (:background nil))))
   `(mumamo-background-chunk-submode1 ((t (:background ,bisque-bg-1))))
   `(mumamo-background-chunk-submode2 ((t (:background ,bisque-bg+2))))
   `(mumamo-background-chunk-submode3 ((t (:background ,bisque-bg+3))))
   `(mumamo-background-chunk-submode4 ((t (:background ,bisque-bg+1))))

   ;; occur
   ;;; See at the end of the let statement

   ;; org-mode
   `(org-agenda-date-today
     ((t (:foreground "white" :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,bisque-fg :weight bold))))
   `(org-checkbox ((t (:background ,bisque-bg+2 :foreground "white"
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,bisque-blue :underline t))))
   `(org-deadline-announce ((t (:foreground ,bisque-red-1))))
   `(org-done ((t (:bold t :weight bold :foreground ,bisque-green+3))))
   `(org-formula ((t (:foreground ,bisque-yellow-2))))
   `(org-headline-done ((t (:foreground ,bisque-green-1))))
   `(org-hide ((t (:foreground ,bisque-bg-1))))
   `(org-level-1 ((t (:foreground ,bisque-orange))))
   `(org-level-2 ((t (:foreground ,bisque-green+1))))
   `(org-level-3 ((t (:foreground ,bisque-blue-1))))
   `(org-level-4 ((t (:foreground ,bisque-yellow-2))))
   `(org-level-5 ((t (:foreground ,bisque-cyan))))
   `(org-level-6 ((t (:foreground ,bisque-green-1))))
   `(org-level-7 ((t (:foreground ,bisque-red-4))))
   `(org-level-8 ((t (:foreground ,bisque-blue-4))))
   `(org-link ((t (:foreground ,bisque-yellow-2 :underline t))))
   `(org-scheduled ((t (:foreground ,bisque-green+4))))
   `(org-scheduled-previously ((t (:foreground ,bisque-red-4))))
   `(org-scheduled-today ((t (:foreground ,bisque-blue+1))))
   `(org-special-keyword ((t (:foreground ,bisque-fg-1 :weight normal))))
   `(org-table ((t (:foreground ,bisque-green+2))))
   `(org-tag ((t (:bold t :weight bold))))
   `(org-time-grid ((t (:foreground ,bisque-orange))))
   `(org-todo ((t (:bold t :foreground ,bisque-red :weight bold :inverse-video t))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:bold t :foreground ,bisque-red :weight bold :underline nil))))
   `(org-column ((t (:background ,bisque-bg-1))))
   `(org-column-title ((t (:background ,bisque-bg-1 :underline t :weight bold))))

   ;; outline
   `(outline-8 ((t (:inherit default))))
   `(outline-7 ((t (:inherit outline-8 :height 1.0))))
   `(outline-6 ((t (:inherit outline-7 :height 1.0))))
   `(outline-5 ((t (:inherit outline-6 :height 1.0))))
   `(outline-4 ((t (:inherit outline-5 :height 1.0))))
   `(outline-3 ((t (:inherit outline-4 :height 1.0))))
   `(outline-2 ((t (:inherit outline-3 :height 1.0))))
   `(outline-1 ((t (:inherit outline-2 :height 1.0))))

   ;; python specific faces
   `(py-builtins-face ((t (:foreground ,bisque-yellow))))
   `(py-pseudo-keyword-face ((t (:foreground ,bisque-yellow))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,bisque-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,bisque-green+2))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,bisque-yellow-2))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,bisque-cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,bisque-green-1))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,bisque-blue+1))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,bisque-yellow-1))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,bisque-green+1))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,bisque-blue-2))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,bisque-orange))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,bisque-green))))
   `( rainbow-delimiters-depth-12-face ((t (:foreground ,bisque-blue-5))))

   ;;rcirc
   `(rcirc-my-nick ((t (:foreground ,bisque-blue))))
   `(rcirc-other-nick ((t (:foreground ,bisque-orange))))
   `(rcirc-bright-nick ((t (:foreground ,bisque-blue+1))))
   `(rcirc-dim-nick ((t (:foreground ,bisque-blue-2))))
   `(rcirc-server ((t (:foreground ,bisque-green))))
   `(rcirc-server-prefix ((t (:foreground ,bisque-green+1))))
   `(rcirc-timestamp ((t (:foreground ,bisque-green+2))))
   `(rcirc-nick-in-message ((t (:foreground ,bisque-yellow))))
   `(rcirc-nick-in-message-full-line ((t (:bold t))))
   `(rcirc-prompt ((t (:foreground ,bisque-yellow :bold t))))
   `(rcirc-track-nick ((t (:inverse-video t))))
   `(rcirc-track-keyword ((t (:bold t))))
   `(rcirc-url ((t (:bold t))))
   `(rcirc-keyword ((t (:foreground ,bisque-yellow :bold t))))

   ;; rpm-mode
   `(rpm-spec-dir-face ((t (:foreground ,bisque-green))))
   `(rpm-spec-doc-face ((t (:foreground ,bisque-green))))
   `(rpm-spec-ghost-face ((t (:foreground ,bisque-red))))
   `(rpm-spec-macro-face ((t (:foreground ,bisque-yellow))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground ,bisque-red))))
   `(rpm-spec-package-face ((t (:foreground ,bisque-red))))
   `(rpm-spec-section-face ((t (:foreground ,bisque-yellow))))
   `(rpm-spec-tag-face ((t (:foreground ,bisque-blue))))
   `(rpm-spec-var-face ((t (:foreground ,bisque-red))))

   ;; rst-mode
   `(rst-level-1-face ((t (:foreground ,bisque-orange))))
   `(rst-level-2-face ((t (:foreground ,bisque-green+1))))
   `(rst-level-3-face ((t (:foreground ,bisque-blue-1))))
   `(rst-level-4-face ((t (:foreground ,bisque-yellow-2))))
   `(rst-level-5-face ((t (:foreground ,bisque-cyan))))
   `(rst-level-6-face ((t (:foreground ,bisque-green-1))))

   ;; sh-mode
   `(sh-heredoc ((t (:foreground ,bisque-green+2))))

   ;; show-paren
   `(show-paren-mismatch ((t (:foreground ,bisque-red-3 :background ,bisque-bg :weight bold))))
   `(show-paren-match ((t (:foreground ,bisque-bg :background ,bisque-blue-1
                                       :weight bold))))
   `(show-paren-match-expression ((t (:background ,bisque-bg+05))))

   ;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))

   ;; SLIME
   `(slime-repl-inputed-output-face ((t (:foreground ,bisque-red))))

   ;; tabbar
   `(tabbar-button ((t (:foreground ,bisque-fg
                                    :background ,bisque-bg))))
   `(tabbar-selected ((t (:foreground ,bisque-fg
                                      :background ,bisque-bg
                                      :box (:line-width -1 :style pressed-button)))))
   `(tabbar-unselected ((t (:foreground ,bisque-fg
                                        :background ,bisque-bg+1
                                        :box (:line-width -1 :style released-button)))))

   ;; tree-sitter
   `(tree-sitter-hl-face:function.call ((t (:foreground
                                            ,bisque-orange-1))))
   `(tree-sitter-hl-face:operator ((t (:foreground ,bisque-fg))))
   `(tree-sitter-hl-face:property ((t (:foreground ,bisque-fg))))
   `(tree-sitter-hl-face:label ((t (:foreground ,bisque-green+4))))

   ;; volatile-highlights
   `(vhl/default-face ((t (:background ,bisque-bg+1))))

   ;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,bisque-yellow :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,bisque-yellow-2
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,bisque-red-1 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,bisque-yellow
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,bisque-green+2 :background ,bisque-bg))))
   `(w3m-lnum-match ((t (:background ,bisque-bg-1
                                     :foreground ,bisque-orange
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,bisque-yellow))))

   ;; whitespace-mode
   `(whitespace-space ((t (:background ,bisque-bg :foreground ,bisque-blue-4))))
   `(whitespace-hspace ((t (:background ,bisque-bg :foreground ,bisque-blue-4))))
   `(whitespace-tab ((t (:background ,bisque-bg :foreground ,bisque-blue-4))))
   `(whitespace-newline ((t (:background ,bisque-bg :foreground ,bisque-blue-4))))
   `(whitespace-trailing ((t (:background ,bisque-red))))
   `(whitespace-line ((t (:background ,bisque-bg :foreground ,bisque-magenta))))
   `(whitespace-space-before-tab ((t (:background ,bisque-orange :foreground ,bisque-orange))))
   `(whitespace-indentation ((t (:background ,bisque-yellow :foreground ,bisque-red))))
   `(whitespace-empty ((t (:background ,bisque-yellow))))
   `(whitespace-space-after-tab ((t (:background ,bisque-yellow :foreground ,bisque-red))))

   ;; wanderlust
   `(wl-highlight-folder-few-face ((t (:foreground ,bisque-red-2))))
   `(wl-highlight-folder-many-face ((t (:foreground ,bisque-red-1))))
   `(wl-highlight-folder-path-face ((t (:foreground ,bisque-orange))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,bisque-blue))))
   `(wl-highlight-folder-zero-face ((t (:foreground ,bisque-fg))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,bisque-blue))))
   `(wl-highlight-message-citation-header ((t (:foreground ,bisque-red-1))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,bisque-red))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,bisque-green+2))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,bisque-blue))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,bisque-blue+1))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,bisque-green))))
   `(wl-highlight-message-headers-face ((t (:foreground ,bisque-red+1))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,bisque-green+2))))
   `(wl-highlight-message-header-contents ((t (:foreground ,bisque-green+1))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,bisque-green+2))))
   `(wl-highlight-message-signature ((t (:foreground ,bisque-green))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,bisque-fg))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,bisque-blue))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,bisque-fg
                                                         :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,bisque-blue))))
   `(wl-highlight-summary-normal-face ((t (:foreground ,bisque-fg))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,bisque-yellow))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,bisque-magenta))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,bisque-fg))))
   `(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))

   ;; which-func-mode
   `(which-func ((t (:foreground ,bisque-green+4))))

   ;; yascroll
   `(yascroll:thumb-text-area ((t (:background ,bisque-bg-1))))
   `(yascroll:thumb-fringe ((t (:background ,bisque-bg-1 :foreground ,bisque-bg-1))))
   )

  ;; occur
  ;; The faces of occur are weird, they cannot be changed in custom-set-faces??
  ;; Needs a setq, says a comment here: https://emacs.stackexchange.com/q/70731/6655
  (defface occur-buffer-name '((t (:foreground "#5c888b" :inverse-video t)))
    "Occur buffer name lineface"
    :group 'basic-faces)
  (setq list-matching-lines-buffer-name-face 'occur-buffer-name)

  ;;; custom theme variables
  (custom-theme-set-variables
   'bisque
   `(ansi-color-names-vector [,bisque-bg ,bisque-red ,bisque-green ,bisque-yellow
                                          ,bisque-blue ,bisque-magenta ,bisque-cyan ,bisque-fg])
   `(ansi-term-color-vector [,bisque-bg ,bisque-red ,bisque-green ,bisque-yellow
                                         ,bisque-blue ,bisque-magenta
                                         ,bisque-cyan ,bisque-fg])

   ;; fill-column-indicator
   `(fci-rule-color ,bisque-bg-05)))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'bisque)


;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:

;;; bisque-theme.el ends here
