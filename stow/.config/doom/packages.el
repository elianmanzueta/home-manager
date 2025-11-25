;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; Org mode stuff
(unpin! org-modern)
(package! org-download)
(package! org-appear)
(package! git-auto-commit-mode)
(package! websocket)
(package! org-roam-ui)
(package! org-super-agenda)

;; Code
(package! just-mode)
(package! fish-mode)
(package! flymake-ruff)
(package! ssh-config-mode)
(package! kdl-mode)
(package! eldoc-box)

;; Themes
(package! ef-themes
  :recipe (:host github :repo "protesilaos/ef-themes"))
(package! standard-themes)
(package! catppuccin-theme)
(package! kanagawa-themes)
(package! inkpot-theme)
(package! kaolin-themes)

;; Shells
(package! eat
  :recipe (:host codeberg
           :repo "akib/emacs-eat"
           :files ("*.el" ("term" "term/*.el") "*.texi"
                   "*.ti" ("terminfo/e" "terminfo/e/*")
                   ("terminfo/65" "terminfo/65/*")
                   ("integration" "integration/*")
                   (:exclude ".dir-locals.el" "*-tests.el"))))
