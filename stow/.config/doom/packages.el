;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

(setenv "LSP_USE_PLISTS" "1")

;; Org mode stuff
(package! org-download)
(package! org-remark)
(package! org-appear
  :recipe (:host github
           :repo "awth13/org-appear"))
(package! org-auto-tangle)
(package! git-auto-commit-mode)
(unpin! org-roam)
(package! websocket)
(package! org-roam-ui)

;; Misc
(package! just-mode)
(package! fish-mode)
(package! gptel)
(package! ultra-scroll
  :recipe ( :host github :repo "jdtsmith/ultra-scroll"))
(package! powershell-ts-mode
  :recipe (:host github :repo "dmille56/powershell-ts-mode"))
(package! nerd-icons-completion)
(package! eat
  :recipe (:host codeberg
           :repo "akib/emacs-eat"
           :files ("*.el" ("term" "term/*.el") "*.texi"
                   "*.ti" ("terminfo/e" "terminfo/e/*")
                   ("terminfo/65" "terminfo/65/*")
                   ("integration" "integration/*")
                   (:exclude ".dir-locals.el" "*-tests.el"))))
