;; Config
(setq user-full-name "Elian Manzueta"
      user-mail-address "elianmanzueta@protonmail.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))
(setq doom-theme 'doom-monokai-pro)

(setq auto-save-default t
      make-backup-files t)
(setq display-line-numbers-type 'relative)
(setq confirm-kill-emacs nil)
(setq initial-frame-alist '((top . 1) (left . 1) (width . 114) (height . 32)))

;; Org
(setq org-directory "~/org/")

;; Avy
(setq avy-timeout-seconds)
(map! :n "s"(after! evil-snipe
              (map! :map evil-snipe-local-mode-map
                    :n "s" nil)))

(map! :n "s" #'avy-goto-char-timer)
(map! :n "s" #'evil-avy-goto-char-timer)
