;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

(setenv "LSP_USE_PLISTS" "1")

(package! org-download)
(package! org-remark)
(package! org-appear
  :recipe (:host github
           :repo "awth13/org-appear"))
(package! just-mode)
(package! git-auto-commit-mode)
(package! anki-editor
  :recipe (:host github :repo "anki-editor/anki-editor"))
(package! ankiorg
  :recipe (:host github :repo "orgtre/ankiorg"))
(package! fish-mode)
(package! org-auto-tangle)
(package! gptel)
(package! websocket)
(unpin! org-roam)
(package! org-roam-ui)
(package! ultra-scroll
  :recipe ( :host github :repo "jdtsmith/ultra-scroll"))
(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"))
(package! powershell-ts-mode
  :recipe (:host github :repo "dmille56/powershell-ts-mode"))
