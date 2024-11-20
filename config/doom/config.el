;; Config
(setq user-full-name "Elian Manzueta"
      user-mail-address "elianmanzueta@protonmail.com")
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))
(setq doom-theme 'doom-monokai-pro)
(setq auto-save-default t
      make-backup-files t)
(setq display-line-numbers-type 'relative)
(setq confirm-kill-emacs nil)
(setq evil-shift-width 2)

;; Terminal Stuff
(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/Users/elian/.nix-profile/bin/fish")
       ((eq system-type 'gnu/linux) "/bin/fish")
       (t "/bin/bash")))

;; Vterm
(after! vterm
  (setq vterm-shell explicit-shell-file-name))

;; Org
(setq org-directory "~/org/")

;; Avy
(after! evil-snipe
  (evil-snipe-mode -1)
  (evil-snipe-override-mode -1))
(map! :n "s" #'avy-goto-char-timer)
(map! :n "s" #'evil-avy-goto-char-timer)

;; Treemacs
(after! treemacs
  (map! :leader "e" #'+treemacs-toggle)
  )
