(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

(setq! go-eldoc-gocode "gocode-gomod")

(after! lsp-mode
  (lsp-register-custom-settings
   '(("gopls.hints" ((assignVariableTypes . t)
                     (compositeLiteralFields . t)
                     (compositeLiteralTypes . t)
                     (constantValues . t)
                     (functionTypeParameters . t)
                     (parameterNames . t)
                     (rangeVariableTypes . t))))))

(add-hook 'lsp-mode-hook #'indent-bars-mode)

(use-package just-mode
  :mode ("justfile\\'" . just-mode)
  :config
  (setq just-indent-offset 4))

(add-hook 'python-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp-inlay-hints-mode)

(setq lsp-pyright-basedpyright-inlay-hints-generic-types t)
(setq lsp-pyright-basedpyright-inlay-hints-variable-types t)
(setq lsp-pyright-basedpyright-inlay-hints-call-argument-names t)
(setq lsp-pyright-basedpyright-inlay-hints-function-return-types t)

(add-hook 'python-mode-local-vars-hook #'flymake-ruff-load)

(setq lsp-pyright-langserver-command "basedpyright")

(setq lsp-pyright-type-checking-mode "basic")

(setq lsp-pyright-venv-path ".")
(setq lsp-pyright-venv-directory ".venv")

(add-hook! 'rustic-mode-hook #'lsp-inlay-hints-mode)
(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)

(map! :leader "e" #'dired-jump)

;; Don't worry, Dirvish is still performant even if you enable all these attributes
(setq dirvish-attributes
      '(vc-state subtree-state collapse git-msg -time file-size file-time))

(setq +lookup-open-url-fn #'eww)

(after! org
  (custom-set-faces!
    '(bold :weight extra-bold)
    '(outline-1 :weight bold :height 1.25)
    '(outline-2 :weight bold :height 1.15)
    '(outline-3 :weight bold :height 1.12)
    '(outline-4 :weight semi-bold :height 1.09)
    '(outline-5 :weight semi-bold :height 1.06)
    '(outline-6 :weight semi-bold :height 1.03)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold)
    '(whitespace-tab :background "242631")
    '(org-document-title :weight extra-bold :height 1.5)
    '(org-verbatim :inherit bold)
    '(org-code :inherit org-block :background "gray15" :foreground "white" :slant italic :weight semi-bold)
    '(markdown-code-face :inherit org-block :background "gray15")
    '(org-scheduled-previously :foreground "dim gray")))

(setq gac-automatically-push-p 't
      gac-automatically-add-new-files-p 't)

(add-hook 'org-mode-hook 'org-auto-tangle-mode)

(setq org-download-image-org-width '450)

(setq org-download-heading-lvl nil)

(use-package! gptel)
(setq gptel-api-key (lambda () (shell-command-to-string "cat ~/.authinfo")))
(setq gptel-default-mode #'org-mode)

(after! gptel
  (setq gptel-prompt-prefix-alist
        '((markdown-mode . "### ")
          (org-mode . "*** Prompt:\n")
          (text-mode . "### "))
        )
  (setq gptel-response-prefix-alist
        '((markdown-mode . "")
          (org-mode . "*** GPT:\n")
          (text-mode . ""))
        ))

(map! :leader
      :desc "Git pull from upstream"
      "g d p" 'magit-pull-from-upstream)

(map! :leader
      :desc "Git push to remote"
      "g d P" 'magit-push-to-remote)

(map! :leader "y" #'yank-from-kill-ring)

(setq user-full-name "Elian Manzueta")
(setq user-mail-address "elianmanzueta@protonmail.com")

(setq auto-save-default t
      make-backup-files t)
(setq confirm-kill-emacs nil)
(setq display-line-numbers-type nil)
(setq evil-shift-width 2)
(setq projectile-project-search-path
      '("~/projects"))

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq which-key-idle-delay 0.5)

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      )

(display-time-mode 1)

(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/agenda/" "\\.org$"))

(add-hook 'org-mode-hook '+org-pretty-mode)
(add-hook '+org-pretty-mode-hook 'org-appear-mode)
(add-hook 'org-mode-hook 'org-display-inline-images)
(setq org-hide-emphasis-markers t)
(setq org-fontify-quote-and-verse-blocks t)

(setq org-roam-capture-templates
      '(("d" "default" plain (file "~/org/roam/templates/default.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n")
         :unnarrowed t)
        ("s" "study" plain (file "~/org/roam/templates/study.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags study:%^{topics}")
         :unarrowed t
         )
        ("w" "work" plain (file "~/org/roam/templates/default.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags work")
         :unarrowed t
         )
        ("i" "ignore" plain (file "~/org/roam/templates/default.org")
         :if-new (file+head "ignore/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags ignore")
         :unarrowed t
         )
        )
      )

(after! org
  (setq org-roam-dailies-capture-templates
        '(("d" "default" plain (file "~/org/roam/templates/daily.org")
           :if-new (file+datetree "daily-journal.org" week)
           :unarrowed t)
          ("w" "work-todo" plain (file "~/org/roam/templates/work-daily.org")
           :if-new (file+datetree "cstate-daily.org" week)
           :unarrowed t)
          )
        )
  )

(use-package! websocket
  :after org)

(use-package! org-roam-ui
  :after org
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/opt/homebrew/bin/fish")
       ((eq system-type 'gnu/linux) "/bin/fish")
       (t "/bin/bash")))

(after! vterm
  (setq vterm-shell explicit-shell-file-name))

(add-load-path! "~/emacs-libvterm")

(setq vterm-buffer-name-string "%s")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))
(setq doom-theme 'doom-snazzy)

(setq doom-vibrant-brighter-comments 't)
(setq doom-vibrant-brighter-modeline 't)

(map! :leader "wa" #'ace-select-window)
