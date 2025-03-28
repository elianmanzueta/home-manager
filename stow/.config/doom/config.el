(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

(setq avy-timeout-seconds 0.35)
(setq avy-all-windows t)
(evil-define-key 'normal 'global (kbd "s") 'avy-goto-char-2)
(after! evil-snipe
  (setq evil-snipe-scope 'whole-visible)
  (setq evil-snipe-smart-case t)
  (evil-define-key '(normal motion) evil-snipe-local-mode-map
    "s" nil
    "S" nil)
  (evil-define-key 'normal 'global (kbd "s") 'avy-goto-char-2))

(use-package! flycheck
  :init
  :config
  (setq flycheck-display-errors-delay 0.1)
  (setq flycheck-idle-change-delay 0.5))

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

(fset #'jsonrpc--log-event #'ignore)
(setq lsp-idle-delay 0.1)
(setq corfu-auto-delay 0.1)
(setq which-key-idle-delay 0.1)

(use-package! powershell
  :mode ("\\.ps1\\'" . powershell-mode)
  :hook (powershell-mode . lsp-mode)
  :config
  (setq powershell-location-of-exe "/mnt/c/Program Files/Powershell/7/pwsh.exe"))

(use-package! powershell-ts-mode)

(use-package! lsp-pyright
  :hook (python-mode . lsp-inlay-hints-mode)
  :config
  (setq lsp-pyright-basedpyright-inlay-hints-generic-types t)
  (setq lsp-pyright-basedpyright-inlay-hints-variable-types t)
  (setq lsp-pyright-basedpyright-inlay-hints-call-argument-names t)
  (setq lsp-pyright-basedpyright-inlay-hints-function-return-types t)

  (setq lsp-pyright-langserver-command "basedpyright")
  (setq lsp-pyright-type-checking-mode "basic")

  (setq lsp-pyright-venv-path ".")
  (setq lsp-pyright-venv-directory ".venv"))

(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)

(use-package! centaur-tabs
  :init
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-set-bar 'right)
  )

(setq +doom-dashboard-pwd-policy "~/")

(use-package! nerd-icons)
(use-package! dirvish
  :config
  (setq dirvish-attributes
        '(nerd-icons vc-state subtree-state collapse git-msg file-size file-time)
        dirvish-side-attributes
        '(vc-state nerd-icons collapse file-size))
  (setq dirvish-default-layout '(0 0.50 0.50))
  (setq dirvish-time-format-string "%d-%m-%y %I:%S:%p %Z")
  )
(map! :leader "e" #'dirvish)

(use-package! eat
  :init
  (setq process-adaptive-read-buffering nil) ; makes EAT a lot quicker!
  (setq eat-term-name "xterm-256color") ; https://codeberg.org/akib/emacs-eat/issues/119"
  (setq eat-kill-buffer-on-exit t))

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
    '(org-document-title :weight extra-bold :height 1.5)
    '(org-verbatim :inherit bold :weight extra-bold)))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))
(setq doom-emoji-font "Noto Color Emoji")

(setq ispell-dictionary "english")

(use-package! gptel
  :init
  (map! :leader "g p" #'gptel)
  :config
  (setq gptel-api-key (lambda () (shell-command-to-string "cat ~/.authinfo")))
  (setq
   gptel-model   'sonar
   gptel-backend (gptel-make-perplexity "Perplexity"
                   :key (lambda () (shell-command-to-string "cat ~/.authinfo-perplexity"))
                   :stream t))

  (setq gptel-default-mode #'org-mode)

  (setq gptel-prompt-prefix-alist
        '((markdown-mode . "### ")
          (org-mode . "*** Prompt:\n")
          (text-mode . "### "))
        )

  (setq gptel-response-prefix-alist
        '((markdown-mode . "")
          (org-mode . "*** GPT:\n")
          (text-mode . ""))
        )

  (setq gptel-directives
        '((default
           . "You are a large language model living in Emacs and a helpful assistant. Respond concisely. If needed, ask for clarification on questions.")
          (programming
           . "You are a large language model and a careful programmer. Provide code and only code as output without any additional text, prompt or note.")
          (writing
           . "You are a large language model and a writing assistant. Respond concisely.")
          (chat
           . "You are a large language model and a conversation partner. Respond concisely."))
        ))

(map! :leader "y" #'yank-from-kill-ring)

(setq user-full-name "Elian Manzueta")
(setq user-mail-address "elianmanzueta@protonmail.com")

(setq auto-save-default t
      make-backup-files t)
(setq confirm-kill-emacs nil)
(setq display-line-numbers-type nil)
(setq evil-shift-width 2)
(setq projectile-project-search-path
      '(("~/projects/" . 3)))

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(after! which-key
  (setq which-key-idle-delay 0.05))

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      )

(display-time-mode 1)

(setq doom-scratch-initial-major-mode 'org-mode)
(setq initial-scratch-message "")

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq gac-automatically-push-p 't
      gac-automatically-add-new-files-p 't)

(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/roam/daily/" "~/org/roam/todo.org"))
(setq org-log-done t)

(setq org-attach-auto-tag nil)
(setq org-id-method 'ts)
(setq org-id-ts-format "%Y-%m-%dT%H%M%S.%6N")
(setq org-attach-id-to-path-function-list
      '(org-attach-id-ts-folder-format
        org-attach-id-uuid-folder-format
        org-attach-id-fallback-folder-format))

(use-package! org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(setq org-download-image-org-width '450)

(setq org-download-heading-lvl nil)

(add-hook 'org-mode-hook '+org-pretty-mode)
(add-hook '+org-pretty-mode-hook 'org-appear-mode)
(add-hook 'org-mode-hook 'org-display-inline-images)
(setq org-hide-emphasis-markers t)
(setq org-fontify-quote-and-verse-blocks t)

(setq org-appear-autolinks t)
(setq org-appear-autoentities t)
(setq org-appear-autokeywords t)

(setq org-roam-node-default-sort 'file-atime)

(setq org-roam-capture-templates
      '(("d" "default" plain (file "~/org/roam/templates/default.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n")
         :unnarrowed t)
        ("s" "study" plain (file "~/org/roam/templates/study.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: study:%^{topics}")
         :unarrowed t
         )
        ("w" "work" plain (file "~/org/roam/templates/default.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: work")
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
  :after org-roam)

(use-package! org-roam-ui
  :after org
  :config
  (setq org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(add-hook! 'org-roam 'org-roam-timestamps-mode)

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i@/!)" "|" "DONE(d!)" "WONT-DO(w@/!)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))
        ))

(setq org-emphasis-alist
      '(("*" org-verbatim bold) ("/" italic) ("_" underline) ("=" org-verbatim verbatim)
        ("~" org-code verbatim) ("+" (:strike-through t)))
      )

(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/opt/homebrew/bin/fish")
       ((eq system-type 'gnu/linux) "/bin/fish")
       (t "/bin/bash")))

(after! vterm
  (setq vterm-shell explicit-shell-file-name))

(add-load-path! "~/emacs-libvterm")

(setq doom-theme 'modus-operandi-tinted)

(setq modus-themes-italic-constructs t)
(setq modus-themes-bold-constructs t)
(setq modus-themes-headings
      '((1 . (1.25))
        (2 . (1.15))
        (3 . (1.12))
        (t . (1.05))))

(setq modus-themes-common-palette-overrides
      '((border-mode-line-active bg-mode-line-active)
        (border-mode-line-inactive bg-mode-line-inactive)))

(setq modus-themes-common-palette-overrides
      '((prose-done green-intense)
        (prose-todo red-intense)))

(use-package! tramp
  :config
  (setq tramp-default-method "rsync")
  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))
  )

(map! :leader "wa" #'ace-select-window)

(use-package! vertico
  :config
  (setq vertico-buffer-display-action '(display-buffer-reuse-window))

  (setq vertico-multiform-categories
        '((symbol (vertico-sort-function . vertico-sort-alpha))
          (file (vertico-sort-function . sort-directories-first)
                )))

  (setq vertico-multiform-commands '((org-roam-node-find grid)
                                     (org-roam-node-insert grid)))

  (setq vertico-grid-min-columns 3)
  )

(defvar +vertico-current-arrow t)

(cl-defmethod vertico--format-candidate :around
  (cand prefix suffix index start &context ((and +vertico-current-arrow
                                                 (not (bound-and-true-p vertico-flat-mode)))
                                            (eql t)))
  (setq cand (cl-call-next-method cand prefix suffix index start))
  (if (bound-and-true-p vertico-grid-mode)
      (if (= vertico--index index)
          (concat #("▶" 0 1 (face vertico-current)) cand)
        (concat #("_" 0 1 (display " ")) cand))
    (if (= vertico--index index)
        (concat
         #(" " 0 1 (display (left-fringe right-triangle vertico-current)))
         cand)
      cand)))

(use-package! vertico-directory
  :after vertico
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package! nerd-icons-completion
  :after (marginalia nerd-icons-completion))

(use-package! orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (syles partial-completion))))
  (orderless-matching-styles '(orderless-literal
                               orderless-regexp
                               )))
