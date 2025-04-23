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

(use-package! centaur-tabs
  :init
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-set-bar 'right)
  )

(use-package! flycheck
  :init
  (setq flycheck-display-errors-delay 0.1))

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

(defun uv-activate ()
  "Activate Python environment managed by uv based on current project directory.
Looks for .venv directory in project root and activates the Python interpreter."
  (interactive)
  (let* ((project-root (project-root (project-current t)))
         (venv-path (expand-file-name ".venv" project-root))
         (python-path (expand-file-name
                       (if (eq system-type 'windows-nt)
                           "Scripts/python.exe"
                         "bin/python")
                       venv-path)))
    (if (file-exists-p python-path)
        (progn
          ;; Set Python interpreter path
          (setq python-shell-interpreter python-path)

          ;; Update exec-path to include the venv's bin directory
          (let ((venv-bin-dir (file-name-directory python-path)))
            (setq exec-path (cons venv-bin-dir
                                  (remove venv-bin-dir exec-path))))

          ;; Update PATH environment variable
          (setenv "PATH" (concat (file-name-directory python-path)
                                 path-separator
                                 (getenv "PATH")))

          ;; Update VIRTUAL_ENV environment variable
          (setenv "VIRTUAL_ENV" venv-path)

          ;; Remove PYTHONHOME if it exists
          (setenv "PYTHONHOME" nil)

          (message "Activated UV Python environment at %s" venv-path))
      (error "No UV Python environment found in %s" project-root))))

(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)

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
(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

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
        '((markdown-mode . "# Prompt:\n")
          (org-mode . "* Prompt:\n")
          (text-mode . "Prompt:\n "))
        )

  (setq gptel-response-prefix-alist
        '((markdown-mode . "# Response:\n")
          (org-mode . "* Response:\n")
          (text-mode . "Response:\n"))
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
(setq display-line-numbers-type 'relative)
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

(use-package! orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  (orderless-matching-styles '(orderless-literal
                               orderless-regexp
                               )))

(setq gac-automatically-push-p 't
      gac-automatically-add-new-files-p 't)

(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/roam/daily/" "~/org/roam/projects/"))
(setq org-log-done t)
(setq org-agenda-hide-tags-regexp ".")
(setq org-agenda-prefix-format '((todo . " ")))

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

(setq org-emphasis-alist
      '(("*" org-verbatim bold) ("/" italic) ("_" underline) ("=" org-verbatim verbatim)
        ("~" org-code verbatim) ("+" (:strike-through t)))
      )

(add-hook 'org-mode-hook '+org-pretty-mode)
(add-hook '+org-pretty-mode-hook 'org-appear-mode)
(add-hook 'org-mode-hook 'org-display-inline-images)
(setq org-hide-emphasis-markers t)
(setq org-fontify-quote-and-verse-blocks t)

(setq org-appear-autolinks t)
(setq org-appear-autoentities t)
(setq org-appear-autokeywords t)

(setq org-modern-star 'replace)

(setq org-agenda-timegrid-use-ampm 't)
(setq org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%m/%d/%y %a>" . "<%m/%d/%y %a %I:%M %p>"))

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
        '(("w" "work-todo" plain (file "~/org/roam/templates/work-todo.org")
           :if-new (file+datetree "work-todo.org" week)
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

(setq org-roam-file-exclude-regexp
      (list "/home/elian/org/.attach/"))

(setq org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)"))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i@/!)" "|" "DONE(d!)" "WONT-DO(w@/!)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))
        ))

(setq ispell-dictionary "english")

(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/opt/homebrew/bin/fish")
       ((eq system-type 'gnu/linux) "/bin/fish")
       (t "/bin/bash")))

(use-package! vterm
  :init
  (setq vterm-shell explicit-shell-file-name)
  (setq vterm-buffer-name-string "vterm: %s"))

(add-load-path! "~/emacs-libvterm")

(setq doom-theme 'doom-one)

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
  (setq tramp-inline-compress-start-size 50000)
  (setq tramp-verbose 1)
  (setq tramp-chunksize 2000)
  (setq tramp-default-method "scp")

  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))

  (setq tramp-ssh-controlmaster-options nil)
  (setq lsp-auto-register-remote-clients nil)
  (setq lsp-warn-no-matched-clients nil)
  )

(connection-local-set-profile-variables
 'remote-direct-async-process
 '((tramp-direct-async-process . t)))
(connection-local-set-profiles
 '(:application tramp :protocol "sshx")
 'remote-direct-async-process)

(use-package! ultra-scroll
  :init
  (setq scroll-conservatively 101
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

(use-package! vertico
  :config
  (setq vertico-buffer-display-action '(display-buffer-reuse-window))

  (setq vertico-multiform-categories
        '((symbol (vertico-sort-function . vertico-sort-alpha))
          (file (vertico-sort-function . vertico-sort-history-alpha)
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

(map! :leader "wa" #'ace-select-window)
