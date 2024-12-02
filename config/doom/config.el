(setq user-full-name "Elian Manzueta")
(setq user-mail-address "elianmanzueta@protonmail.com")
(setq auto-save-default t
      make-backup-files t)
(setq display-line-numbers-type 'relative)
(setq confirm-kill-emacs nil)
(setq evil-shift-width 2)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))
(setq doom-theme 'doom-monokai-spectrum)

(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/Users/elian/.nix-profile/bin/fish")
       ((eq system-type 'gnu/linux) "/bin/fish")
       (t "/bin/bash")))

(after! vterm
  (setq vterm-shell explicit-shell-file-name))

(if (eq system-type 'darwin)
    (map! :leader "ot" #'+term/toggle))

(add-hook 'lsp-mode-hook #'lsp-inlay-hints-mode)
(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)

(setq lsp-pyright-basedpyright-inlay-hints-generic-types t)
(setq lsp-pyright-basedpyright-inlay-hints-variable-types t)
(setq lsp-pyright-basedpyright-inlay-hints-call-argument-names t)
(setq lsp-pyright-basedpyright-inlay-hints-function-return-types t)

(setq lsp-pyright-type-checking-mode "all")

(setq lsp-pyright-venv-path ".")

(setq +lookup-open-url-fn #'eww)

(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org" "\\.org$"))

(add-hook 'org-mode-hook '+org-pretty-mode)
(add-hook '+org-pretty-mode-hook 'org-appear-mode)
(add-hook 'org-mode-hook 'org-display-inline-images)
(setq org-hide-emphasis-markers t)
(setq org-fontify-quote-and-verse-blocks t)

(after! org
  (custom-set-faces!
    '(outline-1 :weight bold :height 1.25)
    '(outline-2 :weight bold :height 1.15)
    '(outline-3 :weight bold :height 1.12)
    '(outline-4 :weight semi-bold :height 1.09)
    '(outline-5 :weight semi-bold :height 1.06)
    '(outline-6 :weight semi-bold :height 1.03)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold)
    '(org-document-title :weight extra-bold :height 1.5)))

(map! :leader "e" #'treemacs)

(map! :leader "y" #'yank-from-kill-ring)

(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)
