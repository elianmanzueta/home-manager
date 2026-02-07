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

(use-package! cperl-mode
  :hook (cperl-mode . flymake-mode)
  :config
  (setq cperl-indent-parens-as-block t
        cperl-close-paren-offset (- cperl-indent-level)
        cperl-invalid-face (quote off)
        cperl-hairy t
        cperl-electric-keywords t
        cperl-highlight-variables-indiscriminately t
        )
  )

(defun my/eldoc-box-scroll-up ()
  "Scroll up in `eldoc-box--frame'."
  (interactive
   (with-current-buffer eldoc-box--buffer
     (with-selected-frame eldoc-box--frame
       (scroll-down 3)))))

(defun my/eldoc-box-scroll-down ()
  "Scroll down in `eldoc-box--frame'."
  (interactive)
  (with-current-buffer eldoc-box--buffer
    (with-selected-frame eldoc-box--frame
      (scroll-up 3))))

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

(use-package! kdl-mode)

(use-package! lsp-mode
  :bind (:map lsp-mode-map
              ("M-k" . lsp-ui-doc-glance))
  :config
  (lsp-register-client   (make-lsp-client
                          :new-connection (lsp-stdio-connection '("fish-lsp" "start"))
                          :activation-fn (lsp-activate-on "fish")
                          :server-id 'fish-lsp))
  (add-to-list 'lsp-language-id-configuration '(fish-mode . "fish")))

(use-package! mason
  :config
  (mason-setup))

(use-package! powershell
  :mode ("\\.ps1\\'" . powershell-ts-mode)
  :hook (powershell-mode . lsp-mode)
  :config
  (setq powershell-location-of-exe "/mnt/c/Program Files/Powershell/7/pwsh.exe"))

(setq lsp-pyright-langserver-command "basedpyright")

(use-package flymake-ruff
  :hook (python-mode . flymake-ruff-load))

(use-package! flycheck
  :config
  (setq flycheck-posframe-mode nil
        flycheck-posframe-border-width 2))

(use-package! flyover
  :hook (lsp-mode . flyover-mode)
  :config
  (setq flyover-show-error-id t
        flyover-virtual-line-type 'curved-arrow
        flyover-base-height 0.9
        lsp-ui-sideline-enable nil))

(custom-set-faces!
  '(flyover-error :inherit error :weight semi-bold :height 0.9)
  '(flyover-info :inherit success :weight semi-bold :height 0.9)
  '(flyover-marker :inherit link :weight semi-bold :height 0.9)
  '(flyover-warning :inherit warning :weight semi-bold :height 0.9))

(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)

(use-package! uv)

(use-package! dirvish
  :config
  (setq dirvish-attributes
        '(nerd-icons collapse file-size file-time))
  (setq dirvish-default-layout '(0 0.11 0.55))
  (setq dirvish-time-format-string "%d-%m-%y %I:%S:%p %Z")
  (setq dired-use-ls-dired 't)
  (setq dirvish-peek-mode 't)
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setq insert-directory-program "gls")))

(map! :leader "e" #'dirvish)

(defun Ex ()
  "Literally just opens dirvish. Made because I keep doing `:Ex`."
  (interactive)
  (dirvish))

(setq doom-theme 'kaolin-bubblegum)

(setq doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 18 :weight 'regular))
(setq doom-emoji-font "Noto Color Emoji")
(setq doom-symbol-font "Symbols Nerd Font Mono")

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

(setq ef-themes-headings
      '((1 . (1.25))
        (2 . (1.15))
        (3 . (1.12))
        (t . (1.05))))

(setq kaolin-themes-italic-comments t
      kaolin-themes-modeline-padded t)

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

(if (executable-find "eza")
    (set-eshell-alias!
     "ls" "eza -lhaF --color=auto"
     "gst" "git status"
     "gcsm" "git commit --signoff --message")
  (set-eshell-alias!
   "ls" "ls -lhaF --color=auto"
   "gst" "git status"
   "gcsm" "git commit --signoff --message"))

(setq user-full-name "Elian Manzueta")
(setq user-mail-address "elianmanzueta@protonmail.com")

(setq undo-limit 80000000
      confirm-kill-emacs nil
      auto-save-default t
      make-backup-files t
      auto-save-default t
      truncate-string-ellipsis "…"
      delete-by-moving-to-trash t
      kill-ring-max 200

      evil-want-fine-undo t
      evil-shift-width 2
      evil-want-C-i-jump t
      +evil-want-move-window-to-wrap-around t
      display-line-numbers-type 'relative
      which-key-idle-delay 0.5
      projectile-project-search-path '(("~/projects/" . 3))
      magit-show-long-lines-warning nil)

(add-to-list 'exec-path "/home/elian/.local/bin/")
(map! :leader "y" #'consult-yank-from-kill-ring)

(map! :leader "wa" #'ace-select-window)

(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

(setq ispell-dictionary "english")
(setq ispell-personal-dictionary "~/.config/doom/dict/.pws")

(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setq initial-scratch-message "")
(setq +doom-dashboard-pwd-policy "~/")

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(use-package! git-auto-commit-mode
  :config
  (setq! gac-automatically-push-p t
         gac-automatically-add-new-files-p t
         gac-debounce-interval 300
         gac-shell-and " ; and "))

(use-package! org-agenda
  :after org
  :config
  (setq org-agenda-timegrid-use-ampm t
        org-display-custom-times t
        org-time-stamp-custom-formats '("<%m/%d/%y %a>" . "<%m/%d/%y %a %I:%M %p>")))

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

(use-package! org-download
  :after org
  :config
  (setq org-download-image-org-width '450))

(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook (lambda () (hl-line-mode -1)))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

(custom-set-faces!
  '(org-document-title :weight extra-bold :height 1.3)
  '(org-verbatim :inherit bold :weight extra-bold))

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
        org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)")))

(use-package! org-modern
  :after org
  :config
  (setq org-modern-star 'replace
        org-modern-replace-stars "◉○✸✿"
        org-modern-block-name nil
        org-modern-timestamp nil
        org-modern-table nil
        org-modern-todo t))

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
         :unarrowed t)

        ("w" "work" plain (file "~/org/roam/templates/default.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: work")
         :unarrowed t)

        ("i" "issue" plain (file "~/org/roam/templates/issue.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: %n\n#+date: %t\n#+filetags: issue")
         :unarrowed t)))

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

(after! org
  (setq +org-capture-todo-file "inbox.org")

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

(use-package! eat
  :init
  (setq process-adaptive-read-buffering nil) ; makes EAT a lot quicker!
  (setq eat-term-name "xterm-256color") ; https://codeberg.org/akib/emacs-eat/issues/119"
  (setq eat-shell "/bin/bash"))

(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)
(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

(use-package! tramp-hlo
  :config
  (tramp-hlo-setup))

(use-package! ssh-config-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("/\\.ssh/config\\(\\.d/.*\\.conf\\)?\\'" . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/sshd?_config\\(\\.d/.*\\.conf\\)?\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode)))

(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

(use-package! vertico
  :defer t
  :config
  (setq vertico-buffer-display-action '(display-buffer-reuse-window))

  (setq vertico-multiform-categories
        '((symbol (vertico-sort-function . vertico-sort-alpha))
          (file (vertico-sort-function . vertico-sort-history-alpha)
                ))))

(use-package! vertico-directory
  :after vertico
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
