;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Load Doom's auto-generated envvars
(doom-load-envvars-file "~/.config/emacs/.local/env")

;; Per-machine override (Pantheon laptop/host)
(when (file-regular-p (expand-file-name "~/.work-pantheon"))
  (doom-load-envvars-file "~/.config/doom/pantenton.envvar"))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Masood Ahmed"
      user-mail-address "me@ahmedmasood.com")

;; Per-machine override (Pantheon laptop/host)
(when (file-regular-p (expand-file-name "~/.work-pantheon"))
  (setq user-mail-address "masoodahmed@pantheon.io"))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "MesloLGS Nerd Font" :size 14))
;; (setq doom-font (font-spec :family "JuliaMono" :size 14 :weight 'semi-light)
      ;; doom-variable-pitch-font (font-spec :family "JuliaMono" :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(custom-theme-set-faces!
  'doom-tokyo-night
  '(org-level-8 :inherit outline-3 :height 1.0)
  '(org-level-7 :inherit outline-3 :height 1.0)
  '(org-level-6 :inherit outline-3 :height 1.1)
  '(org-level-5 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-3 :height 1.3)
  '(org-level-3 :inherit outline-3 :height 1.4)
  '(org-level-2 :inherit outline-2 :height 1.5)
  '(org-level-1 :inherit outline-1 :height 1.6)
  '(org-document-title :height 1.8 :bold t :underline nil))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-tokyo-night)
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-modern-table-vertical 1)
(setq org-modern-table t)
(add-hook 'org-mode-hook #'hl-todo-mode)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; enable language-aware word wrap in most buffers
(+global-word-wrap-mode t)

(setq projectile-project-search-path '("~/code/"))

;; Non-POSIX shells (particularly Fish and Nushell) can cause
;; unpredictable issues with any Emacs utilities that spawn child
;; processes from shell commands (like diff-hl and in-Emacs
;; terminals). To get around this, configure Emacs to use a POSIX shell
;; internally, e.g.
;;
;; add to $DOOMDIR/config.el: (setq shell-file-name (executable-find "bash"))
;; (setq shell-file-name "/run/current-system/sw/bin/bash")

;; Emacs' terminal emulators can be safely configured to use your
;; original $SHELL:
;;
;; add to $DOOMDIR/config.el: (setq-default vterm-shell "/nix/store/ifd04qwh32hsg1v05678fa66g3w8pi3b-fish-4.0.2/bin/fish")
;; (setq-default explicit-shell-file-name "/nix/store/ifd04qwh32hsg1v05678fa66g3w8pi3b-fish-4.0.2/bin/fish")
;; (setq-default vterm-shell "/etc/profiles/per-user/masoodahmed/bin/fish")
;; (setq-default explicit-shell-file-name "/etc/profiles/per-user/masoodahmed/bin/fish")

;; don't bug me when I'm trying to exit
(setq confirm-kill-emacs nil)
(setq confirm-kill-processes nil)

;; gptel + magit integration
(use-package! gptel-magit
  :after magit
  :hook (magit-mode . gptel-magit-install))

;; gptel + forge integration
(use-package! gptel-forge-prs
  :after forge
  :config
  (gptel-forge-prs-install))

(use-package slack
  :config
  (slack-register-team
   :name "pantheon"
   :token (auth-source-pick-first-password
           :host "pantheon.slack.com"
           :user "masoodahmed@pantheon.io^token")
   :enterprise-token (auth-source-pick-first-password
           :host "pantheon.slack.com"
           :user "masoodahmed@pantheon.io^enterprise-token")
   :cookie (auth-source-pick-first-password
            :host "pantheon.slack.com"
            :user "masoodahmed@pantheon.io^cookie")
   :full-and-display-names t
   :default t
   :subscribed-channels nil ;; using slack-extra-subscribed-channels because I can change it dynamically
   ))

(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))
