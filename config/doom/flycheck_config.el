(setq user-full-name "Elian Manzueta")
(setq user-mail-address "elianmanzueta@protonmail.com")
(setq auto-save-default t
      make-backup-files t)
(setq display-line-numbers-type 'relative)
(setq confirm-kill-emacs nil)
(setq evil-shift-width 2)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))
(setq doom-theme 'doom-gruvbox)

(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/Users/elian/.nix-profile/bin/fish")
       ((eq system-type 'gnu/linux) "/bin/fish")
       (t "/bin/bash")))

(after! vterm
  (setq vterm-shell explicit-shell-file-name))

(after! term
  (if (eq system-type 'darwin)
      (map! :leader "ot" #'+term/toggle)))

(after! org
  (setq org-directory "~/org/")
  (setq org-agenda-files (directory-files-recursively "~/org" "\\.org$"))
  )

(after! evil-snipe
  (evil-snipe-mode -1)
  (evil-snipe-override-mode -1)
  )

(after! treemacs
  (map! :leader "e" #'treemacs)
  )

(map! :leader "y" #'yank-from-kill-ring)

(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)