(map! :leader "wa" #'ace-select-window)

(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

(use-package! avy
  :config
  (setq avy-timeout-seconds 0.35)
  (setq avy-all-windows t)
  (evil-define-key 'normal 'global (kbd "s") 'avy-goto-char-2))

(after! evil-snipe
  (setq evil-snipe-scope 'whole-visible)
  (setq evil-snipe-smart-case t)
  (evil-define-key '(normal motion) evil-snipe-local-mode-map
    "s" nil
    "S" nil)
  (evil-define-key 'normal 'global (kbd "s") 'avy-goto-char-2)
  (evil-define-key 'normal 'global (kbd "f") 'avy-goto-char))

(after! lsp-mode
  (lsp-register-custom-settings
   '(("gopls.hints" ((assignVariableTypes . t)
                     (compositeLiteralFields . t)
                     (compositeLiteralTypes . t)
                     (constantValues . t)
                     (functionTypeParameters . t)
                     (parameterNames . t)
                     (rangeVariableTypes . t))))))

(use-package just-mode
  :defer t
  :mode ("justfile\\'" . just-mode)
  :config
  (setq just-indent-offset 4))

(use-package! powershell
  :mode ("\\.ps1\\'" . powershell-ts-mode)
  :hook (powershell-mode . lsp-mode)
  :config
  (setq powershell-location-of-exe "/mnt/c/Program Files/Powershell/7/pwsh.exe"))

(setq lsp-pyright-langserver-command "basedpyright")

(use-package flymake-ruff
  :hook (python-mode . flymake-ruff-load))

(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)

(use-package! kdl-mode)

(use-package completion-preview
  :hook
  ((prog-mode text-mode eshell-mode) . completion-preview-mode)
  :config
  (setq completion-preview-minimum-symbol-length 3))

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
  '(org-verbatim :inherit bold :weight extra-bold))

(use-package! dirvish
  :config
  (setq dirvish-attributes
        '(file-modes nerd-icons vc-state file-mode subtree-state collapse file-size file-time))
  (setq dirvish-default-layout '(1 0.11 0.55))
  (setq dirvish-time-format-string "%d-%m-%y %I:%S:%p %Z")
  (setq dired-use-ls-dired 't)
  (setq dirvish-peek-mode 't)
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setq insert-directory-program "gls")))

(map! :leader "e" #'dirvish)

(setq doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 18 :weight 'medium))
(setq doom-emoji-font "Noto Color Emoji")
(setq doom-symbol-font "Symbols Nerd Font Mono")
(setq doom-theme 'doom-moonlight)

(use-package! eat
  :init
  (setq process-adaptive-read-buffering nil) ; makes EAT a lot quicker!
  (setq eat-term-name "xterm-256color") ; https://codeberg.org/akib/emacs-eat/issues/119"
  (setq eat-shell "/bin/bash"))

(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)
(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

(defun my/insert-heading-plus-one ()
  (interactive)
  (if (org-at-heading-p)
      (let
          ((header-level
            (nth 0 (org-heading-components))))
        (insert (make-string (+ 1 header-level) ?*)))))

(defun +eshell-default-prompt-fn ()
  "Generate the prompt string for eshell. Use for `eshell-prompt-function'."
  (require 'shrink-path)
  (concat (if (bobp) "" "\n")
          (propertize (eshell-user-login-name) 'face 'nerd-icons-green)
          (propertize " in " 'face '+eshell-prompt-pwd)

          (let ((pwd (eshell/pwd)))
            (propertize (if (equal pwd "~")
                            pwd
                          (abbreviate-file-name pwd))
                        'face 'nerd-icons-green))

          "\n"
          (propertize "$" 'face (if (zerop eshell-last-command-status) 'success 'error))
          " "))

(set-eshell-alias!
 "ls" "ls -lhaF --color=auto"
 "gst" "git status"
 "gcsm" "git commit --signoff --message")

(use-package! gptel
  :defer t
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

(add-to-list 'exec-path "/home/elian/.local/bin/")

(setq ispell-dictionary "english")
(setq ispell-personal-dictionary "~/home-manager/stow/.config/doom/dict/.pws")

(setq user-full-name "Elian Manzueta")
(setq user-mail-address "elianmanzueta@protonmail.com")

(setq auto-save-default t
      make-backup-files t)
(setq confirm-kill-emacs nil)
(setq display-line-numbers-type 'relative)
(setq evil-shift-width 2)
(setq projectile-project-search-path
      '(("~/projects/" . 3)))
(setq which-key-idle-delay 0.5)

(setq-default
 delete-by-moving-to-trash t)

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      )

(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setq initial-scratch-message "")

                                        ; Focus new windows after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(map! :leader "y" #'yank-from-kill-ring)

(use-package! nov
  :defer t
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-variable-pitch nil))

(use-package! org-super-agenda
  :after org
  :config
  (setq org-agenda-start-day nil)
  (setq org-super-agenda-header-map (make-sparse-keymap))
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-overriding-header "")
  (setq org-agenda-span 'day))


(setq org-agenda-custom-commands
      '(("n" "Super-agenda view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                          :time-grid t)))))

          (alltodo "" ((org-agenda-overriding-header "Inbox")
                       (org-super-agenda-groups
                        '((:name "Important"
                           :and (:priority>= "B" :tag "inbox")
                           :order 1)
                          (:name "In progress"
                           :and (:tag "inbox" :todo ("IN-PROGRESS"))
                           :order 2)
                          (:name "Entries"
                           :and (:todo "TODO" :tag "inbox")
                           :order 3)
                          (:name "On hold"
                           :and (:todo "HOLD" :tag "inbox")
                           :order 4)
                          (:name "Notes"
                           :todo "NOTE"
                           :order 5)
                          (:discard (:anything t))))))

          (todo "" ((org-agenda-overriding-header "Projects")
                    (org-super-agenda-groups
                     '((:name "Projects - Important"
                        :and (:todo ("TODO" "IN-PROGRESS") :tag "projects" :priority>= "B"))
                       (:name "Projects"
                        :and (:tag "projects" :todo ("TODO")))
                       (:name "Projects - On hold"
                        :and (:todo ("HOLD") :tag "projects"))
                       (:name "Notes"
                        :and (:tag "projects" :todo "NOTE"))
                       (:discard (:anything t))))))))))

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook (lambda () (hl-line-mode -1)))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

(use-package! org
  :defer t
  :bind (:map org-mode-map
              ("M-o" . org-appear-mode))
  :config
  (setq org-hide-emphasis-markers t
        org-fontify-quote-and-verse-blocks t
        org-auto-align-tags nil
        org-tags-column 0
        org-agenda-tags-column 0
        org-ellipsis " ▼"

        org-startup-folded 'show2levels

        org-emphasis-alist '(("*" org-verbatim bold) ("/" italic) ("_" underline) ("=" org-verbatim verbatim)
                             ("~" org-code verbatim) ("+" (:strike-through t)))

        org-appear-autolinks t
        org-appear-autoentities t
        org-appear-autokeywords t

        org-directory "~/org/"
        org-agenda-files '("~/org/roam/daily/" "~/org/roam/professional/" "~/org/inbox.org")
        org-log-done t
        org-agenda-hide-tags-regexp "todo\\|work\\|workinfo\\|daily"
        ))

(use-package! org-modern
  :after org
  :config
  (setq org-modern-star 'fold
        org-modern-replace-stars "◉○✸✿"
        org-modern-block-name nil
        ;; org-modern-keyword nil
        org-modern-timestamp nil
        ;; org-modern-priority t
        org-modern-todo t
        ;; org-modern-table nil
        ))

(use-package! org-agenda
  :after org
  :config
  (setq org-agenda-timegrid-use-ampm t
        org-display-custom-times t
        org-time-stamp-custom-formats '("<%m/%d/%y %a>" . "<%m/%d/%y %a %I:%M %p>")))

(use-package! git-auto-commit-mode
  :config
  (setq! gac-automatically-push-p t
         gac-automatically-add-new-files-p t
         gac-shell-and " ; and "))

(use-package! anki-editor
  :defer t)
(use-package! ankiorg
  :defer t)

(use-package! org-attach
  :after org
  :config
  (setq org-attach-auto-tag nil
        org-attach-store-link-p 'file
        org-attach-id-to-path-function-list '(org-attach-id-ts-folder-format
                                              org-attach-id-uuid-folder-format
                                              org-attach-id-fallback-folder-format)))
(setq org-id-method 'ts)
(setq org-id-ts-format "%Y-%m-%dT%H%M%S.%6N")

(use-package! ox-hugo
  :defer t)

(use-package! org-auto-tangle
  :after org
  :hook (org-mode . org-auto-tangle-mode))

(use-package! org-download
  :after org
  :config
  (setq org-download-image-org-width '450))

(setq +org-capture-todo-file "inbox.org")

(use-package! org-roam
  :after org
  :config
  (setq org-roam-node-default-sort 'file-mtime
        org-roam-file-exclude-regexp (list "~/org/.attach/")))

(defun my/org-roam-node-find-prof ()
  (interactive)
  (org-roam-node-find nil "@professional " nil))

(map! :leader "nrp" 'my/org-roam-node-find-prof)

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
        ("i" "issue" plain (file "~/org/roam/templates/issue.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: issue")
         :unarrowed t
         )))

(after! org
  (setq org-roam-dailies-capture-templates
        '(("w" "work-todo" plain (file "~/org/roam/templates/work-todo.org")
           :if-new (file+datetree "work-inbox.org" week)
           :unarrowed t))))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)"))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i@/!)" "|" "DONE(d!)" "WONT-DO(w@/!)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")
          (sequence "NOTE(N)" "HOLD(h)" "|"))))

(setq org-todo-keyword-faces
      '(("[-]" . +org-todo-active) ("STRT" . +org-todo-active)
        ("[?]" . +org-todo-onhold) ("WAIT" . +org-todo-onhold)
        ("HOLD" . +org-todo-onhold) ("PROJ" . +org-todo-project)
        ("NO" . +org-todo-cancel) ("KILL" . +org-todo-cancel)
        ("NOTE" . flymake-note-echo)))

(setq org-modern-todo-faces
      '(("KILL" :inverse-video t :inherit +org-todo-cancel)
        ("NO" :inverse-video t :inherit +org-todo-cancel)
        ("PROJ" :inverse-video t :inherit +org-todo-project)
        ("HOLD" :inverse-video t :inherit +org-todo-onhold)
        ("WAIT" :inverse-video t :inherit +org-todo-onhold)
        ("[?]" :inverse-video t :inherit +org-todo-onhold)
        ("STRT" :inverse-video t :inherit +org-todo-active)
        ("NOTE" :inverse-video t :inherit flymake-note-echo)
        ("[-]" :inverse-video t :inherit +org-todo-active)))

(use-package! ssh-config-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("/\\.ssh/config\\(\\.d/.*\\.conf\\)?\\'" . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/sshd?_config\\(\\.d/.*\\.conf\\)?\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode)))

(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

(setq explicit-shell-file-name
      (cond
       ((eq system-type 'darwin) "/opt/homebrew/bin/fish")
       ((eq system-type 'gnu/linux)
        (let ((cmd (shell-command-to-string "uname -a")))
          (if (string-match "NixOS" cmd)
              "/run/current-system/sw/bin/fish"
            "/bin/fish")))
       (t "/bin/sh")))  ; Default to bourne shell for other systems

(use-package! vterm
  :init
  (setq vterm-shell explicit-shell-file-name)
  (setq vterm-buffer-name-string "vterm: %s"))

(add-load-path! "~/emacs-libvterm")

(setq catppuccin-flavor 'mocha
      catppuccin-italic-comments t
      catppuccin-italic-variables t
      catppuccin-highlight-matches t)

(setq modus-themes-italic-constructs t)
(setq modus-themes-bold-constructs t)
(setq modus-themes-headings
      '((1 . (1.25))
        (2 . (1.15))
        (3 . (1.12))
        (t . (1.05))))

;; (setq modus-themes-common-palette-overrides
;;       '((border-mode-line-active bg-mode-line-active)
;;         (border-mode-line-inactive bg-mode-line-inactive)))

;; (setq modus-themes-common-palette-overrides
;;       '((prose-done green-intense)
;;         (prose-todo red-intense)))

(setq ef-themes-headings
      '((1 . (1.25))
        (2 . (1.15))
        (3 . (1.12))
        (t . (1.05))))

(use-package! tramp
  :config
  (setq magit-tramp-pipe-stty-settings 'pty
        remote-file-name-inhibit-locks t
        tramp-use-scp-direct-remote-copying t
        remote-file-name-inhibit-auto-save-visited t)

  (connection-local-set-profile-variables
   'remote-direct-async-process
   '((tramp-direct-async-process . t)))

  (connection-local-set-profiles
   '(:application tramp :protocol "scp")
   'remote-direct-async-process)

  (with-eval-after-load 'tramp
    (with-eval-after-load 'compile
      (remove-hook 'compilation-mode-hook #'tramp-compile-disable-ssh-controlmaster-options))))

(use-package! vertico
  :defer t
  :config
  (setq vertico-buffer-display-action '(display-buffer-reuse-window))

  (setq vertico-multiform-categories
        '((symbol (vertico-sort-function . vertico-sort-alpha))
          (file (vertico-sort-function . vertico-sort-history-alpha)
                )))

  (setq vertico-multiform-commands '((org-roam-node-find grid)
                                     (org-roam-node-insert grid)))

  (if (eq system-type 'android)
      (setq vertico-grid-min-columns 1)
    (setq vertico-grid-min-columns 3))
  )

(use-package! vertico-directory
  :after vertico
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
