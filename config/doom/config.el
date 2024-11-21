(setq user-full-name "Elian Manzueta")
(setq user-mail-address "elianmanzueta@protonmail.com")
(setq auto-save-default t
      make-backup-files t)
(setq display-line-numbers-type 'relative)
(setq confirm-kill-emacs nil)
(setq evil-shift-width 2)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18))
(setq doom-theme 'doom-monokai-pro)

(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/Users/elian/.nix-profile/bin/fish")
       ((eq system-type 'gnu/linux) "/usr/bin/fish")
       (t "/bin/bash")))

(after! vterm
  (setq vterm-shell explicit-shell-file-name))

(setq org-directory "~/org/")

(after! evil-snipe
  (evil-snipe-mode -1)
  (evil-snipe-override-mode -1))
(map! :n "s" #'avy-goto-char-timer)
(map! :n "s" #'evil-avy-goto-char-timer)

(after! treemacs
  (map! :leader "e" #'treemacs)
  )

(map! :leader "y" #'yank-from-kill-ring)
