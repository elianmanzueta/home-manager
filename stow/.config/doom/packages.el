;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; Org mode stuff
(package! org-download)
(package! org-remark)
(package! org-appear)
(package! org-auto-tangle)
(package! git-auto-commit-mode)
(package! websocket)
(package! org-roam-ui)
(package! org-super-agenda)
(package! ox-hugo)
;; (package! org-supertag
;;   :recipe (:host github
;;            :repo "yibie/org-supertag"))

;; Code
(package! just-mode)
(package! fish-mode)
;; (package! powershell-ts-mode
;;   :recipe (:host github :repo "dmille56/powershell-ts-mode"))
(package! flymake-ruff)
;; (package! eglot-booster
;;   :recipe (:host github :repo "jdtsmith/eglot-booster"))
(package! ssh-config-mode)

;; Themes
(package! ef-themes)
(package! standard-themes)
(package! catppuccin-theme)
(package! kanagawa-themes)

;; Misc
(package! eat
  :recipe (:host codeberg
           :repo "akib/emacs-eat"
           :files ("*.el" ("term" "term/*.el") "*.texi"
                   "*.ti" ("terminfo/e" "terminfo/e/*")
                   ("terminfo/65" "terminfo/65/*")
                   ("integration" "integration/*")
                   (:exclude ".dir-locals.el" "*-tests.el"))))
(package! nov)
