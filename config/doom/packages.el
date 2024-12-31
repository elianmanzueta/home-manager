;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

(package! org-download)
(package! org-remark)
(package! org-appear
  :recipe (:host github
           :repo "awth13/org-appear"))

(package! pet)
(package! just-mode)
(package! git-auto-commit-mode)
(package! anki-editor
  :recipe (:host github :repo "anki-editor/anki-editor"))
(package! ankiorg
  :recipe (:host github :repo "orgtre/ankiorg"))
(package! fish-mode)
