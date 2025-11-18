;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Masood Ahmed"
      user-mail-address "me@ahmedmasood.com")

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
;; (setq doom-font (font-spec :family "MesloLGS Nerd Font" :size 16))
(setq doom-font (font-spec :family "JuliaMono" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JuliaMono" :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)
;; (setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;; set cursor color/shape defaults
(after! evil
  (setq evil-default-cursor '(t "#EBCB8B")
        evil-normal-state-cursor '("#EBCB8B" box)
        evil-insert-state-cursor '("#FFFFFF" bar)
        evil-visual-state-cursor '("#FFFFFF" hbar))
  (evil-ex-define-cmd "W" 'save-buffer))

;; enable language-aware word wrap in most buffers
(+global-word-wrap-mode t)

;; make Org auto-insert a timestamp when a task cycles to DONE
(after! org-mode
  (setq org-log-done 'time)
  (add-hook 'org-mode-hook #'auto-fill-mode))

;; change Git commit summary length
(after! magit
  (setq magit-commit-summary-max-length 72))

(after! markdown-mode
  ;; allow .mdx files to use markdown-mode
  (add-hook 'markdown-mode-hook #'auto-fill-mode))
(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

(setq
 projectile-project-root-functions '(projectile-root-marked
                                     projectile-root-local
                                     projectile-root-top-down
                                     projectile-root-top-down-recurring
                                     projectile-root-bottom-up))

(setq projectile-project-search-path '("~/code/"))

;; turn off spellcheck for text-mode (and all derived modes)
(after! text-mode
  (remove-hook! 'text-mode-hook #'spell-fu-mode))

;; enable spellchecking in markdown mode
(after! markdown-mode
  (add-hook! 'markdown-mode-hook #'spell-fu-mode))

;; Non-POSIX shells (particularly Fish and Nushell) can cause
;; unpredictable issues with any Emacs utilities that spawn child
;; processes from shell commands (like diff-hl and in-Emacs
;; terminals). To get around this, configure Emacs to use a POSIX shell
;; internally, e.g.
;;
;; add to $DOOMDIR/config.el: (setq shell-file-name (executable-find "bash"))
(setq shell-file-name "/run/current-system/sw/bin/bash")

;; Emacs' terminal emulators can be safely configured to use your
;; original $SHELL:
;;
;; add to $DOOMDIR/config.el: (setq-default vterm-shell "/nix/store/ifd04qwh32hsg1v05678fa66g3w8pi3b-fish-4.0.2/bin/fish")
;; (setq-default explicit-shell-file-name "/nix/store/ifd04qwh32hsg1v05678fa66g3w8pi3b-fish-4.0.2/bin/fish")
(setq-default vterm-shell "/etc/profiles/per-user/masoodahmed/bin/fish")
(setq-default explicit-shell-file-name "/etc/profiles/per-user/masoodahmed/bin/fish")

;; don't bug me when I'm trying to exit
(setq confirm-kill-emacs nil)
(setq confirm-kill-processes nil)

;; (after! nix-mode
;; (set-formatter! 'nixfmt '("nix" "fmt" filepath) :modes '(nix-mode)))
