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

(map! :leader :desc "Inlay hints mode" "t h" #'lsp-inlay-hints-mode)

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

(setq lsp-idle-delay 0.3)
(setq corfu-auto-delay 0.2)
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

(setq-hook! 'python-mode-hook +format-with 'ruff)

(setq lsp-rust-analyzer-display-chaining-hints t)
(setq lsp-rust-analyzer-display-closure-return-type-hints t)
(setq lsp-rust-analyzer-display-parameter-hints t)

(use-package completion-preview
  :hook
  ((prog-mode text-mode eshell-mode) . completion-preview-mode)
  :config
  (setq completion-preview-minimum-symbol-length 3)
  (setq completion-preview-completion-styles '(basic partial-completion))
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

(setq doom-font "IosevkaTerm Nerd Font Mono")
(setq doom-emoji-font "Noto Color Emoji")
(setq doom-symbol-font "Symbols Nerd Font Mono")
(setq doom-theme 'doom-monokai-spectrum)

(use-package! eat
  :init
  (setq process-adaptive-read-buffering nil) ; makes EAT a lot quicker!
  (setq eat-term-name "xterm-256color")) ; https://codeberg.org/akib/emacs-eat/issues/119"
  (setq eat-shell "/bin/bash")

(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)
(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

(defun +eshell-default-prompt-fn ()
  "Generate the prompt string for eshell. Use for `eshell-prompt-function'."
  (require 'shrink-path)
  (concat (if (bobp) "" "\n")
          (propertize (eshell-user-login-name) 'face 'nerd-icons-green)
          (propertize " in " 'face '+eshell-prompt-pwd)
          (let ((pwd (eshell/pwd)))
            (propertize (if (equal pwd "~")
                            pwd
                          (abbreviate-file-name (shrink-path-file pwd)))
                        'face 'nerd-icons-green))
          ;; (propertize (+eshell--current-git-branch)
          ;;             'face '+eshell-prompt-git-branch)
          (propertize " on " 'face '+eshell-prompt-pwd)
          (propertize (shell-command-to-string "hostname -s") 'face 'nerd-icons-green)
          (propertize "$" 'face (if (zerop eshell-last-command-status) 'success 'error))
          " "))

(set-eshell-alias!
 "ls" "ls -lhaF --color=auto"
 "gst" "git status"
 "gcsm" "git commit --signoff --message")

(setq vterm-tramp-shells '(("ssh" "/bin/bash") ("scp" "/bin/bash") ("docker" "/bin/sh")))

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

(use-package! gptel
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
 delete-by-moving-to-trash t)

(after! which-key
  (setq which-key-idle-delay 0.05))

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      )

(display-time-mode 1)

(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setq initial-scratch-message "")

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(defun nano-popup (buffer)
  "Toggle a popup window at the bottom of frame displaying the given
BUFFER. The size fo the window is saved such that toggling the window
does not change the window size."

  (interactive)
  (let ((window (get-buffer-window buffer)))
    (if window
        (progn
          (with-current-buffer buffer
            (setq-local window-height (window-height window))) ;
          (delete-window window))
      (progn
        (with-current-buffer buffer
          (pop-to-buffer buffer
                         `((display-buffer-at-bottom)
                           ,(when (boundp 'window-height)
                              (cons 'window-height window-height)))))
        (setq-local window-height (window-height (get-buffer-window buffer)))))))
(provide 'nano-popup)

(defun nano-term ()
  "Show/hide eat terminal at the bottom of the frame."

  (interactive)
  (if (get-buffer eat-buffer-name)
      (nano-popup eat-buffer-name)
    (let ((display-buffer-alist `(("\\*eat\\*"
                                   (display-buffer-at-bottom)
                                   (window-height . 12)
                                   (dedicated . t)))))
      (eat-other-window nil -1))))


(defun my/prompt-for-eat-term ()
  "Prompt for a terminal name before opening EAT."


  (interactive)
  (let ((term-name (read-string "Terminal name: " nil nil "eat")))
    (setq-local eat-buffer-name term-name)
    (eat)))

(defun my/gptel-popup ()
  "Create a nano-popup window with a gptel session"

  (interactive)
  (if (get-buffer "gptel-popup")
      (nano-popup (get-buffer "gptel-popup"))
    (let ((display-buffer-alist `(("\\gptel-popup\\"
                                   (display-buffer-at-bottom)
                                   (window-height . 20)
                                   (dedicated . t)))))
      (gptel "gptel-popup" nil nil))))

;; (map! :leader "o t" #'nano-term)
;; (map! :leader "o T" #'my/prompt-for-eat-term)
(map! :leader "g p" #'my/gptel-popup)
(map! :leader "g P" #'gptel)

(use-package! orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  (orderless-matching-styles '(orderless-literal
                               orderless-regexp
                               )))

(use-package! org-super-agenda
  :after org-agenda
  :config
  (setq org-agenda-start-day nil)
  (setq org-agenda-block-separator nil)
  (setq org-agenda-start-day nil)
  (setq org-habit-show-habits-only-for-today nil)
  (setq org-habit-show-all-today t)
  (setq org-super-agenda-unmatched-name "Misc")
  (setq org-super-agenda-header-map (make-sparse-keymap))
  )

(setq org-agenda-custom-commands
      '(("n" "Agenda view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                          :time-grid t
                          :date today
                          :scheduled today
                          :order 1)))))

          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '(;; Each group has an inmplicit boolean OR operator between its selectors.
                          (:name "Today"
                           :deadline today
                           :face (:background "black")
                           :log t)
                          (:name "In progress"
                           :todo ("IN-PROGRESS"))
                          (:name "Work Important"
                           :and (:priority>= "B" :category "Work" :todo ("TODO" "NEXT")))
                          (:name "Work other"
                           :and (:category "Work" :todo ("TODO" "NEXT")))
                          (:name "Habits"
                           :tag "habits"
                           :time-grid t)
                          (:name "Scheduled - Future"
                           :time-grid t
                           :scheduled future)
                          (:name "Important"
                           :priority "A")
                          (:name "Issues"
                           :tag "issues"
                           :order 0)
                          (:priority<= "B")
                          ))))))))

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

(add-hook 'org-mode-hook '+org-pretty-mode)
(add-hook '+org-pretty-mode-hook 'org-appear-mode)
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook (lambda () (hl-line-mode -1)))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

(use-package! org
  :config
  (setq org-hide-emphasis-markers t
        org-fontify-quote-and-verse-blocks t
        org-auto-align-tags nil
        org-tags-column 0
        org-agenda-tags-column 0
        org-ellipsis " ▼"

        org-startup-folded 'content

        org-emphasis-alist '(("*" org-verbatim bold) ("/" italic) ("_" underline) ("=" org-verbatim verbatim)
                             ("~" org-code verbatim) ("+" (:strike-through t)))

        org-appear-autolinks t
        org-appear-autoentities t
        org-appear-autokeywords t
        ))

(use-package! org-modern
  :config
  (setq org-modern-star 'replace
        org-modern-replace-stars "◉○✸✿"
        ))

(use-package! org-agenda
  :config
  (setq org-agenda-timegrid-use-ampm 't
        org-display-custom-times t
        org-time-stamp-custom-formats '("<%m/%d/%y %a>" . "<%m/%d/%y %a %I:%M %p>")))

(setq gac-automatically-push-p 't
      gac-automatically-add-new-files-p 't)

(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/roam/daily/" "~/org/roam/professional/" "~/org/inbox.org"))
(setq org-log-done t)
(setq org-agenda-hide-tags-regexp "todo\\|work\\|workinfo\\|daily")
;; (setq org-agenda-prefix-format '((todo . " ")))

(use-package! anki-editor)

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

(use-package! org-download
  :config
  (setq org-download-image-org-width '450
        org-download-heading-lvl nil))

(setq +org-capture-todo-file "inbox.org")

(setq org-roam-node-default-sort 'file-mtime)

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
         )
        ))

(after! org
  (setq org-roam-dailies-capture-templates
        '(("w" "work-todo" plain (file "~/org/roam/templates/work-todo.org")
           :if-new (file+datetree "work-inbox.org" week)
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
  (setq tramp-default-method "scp")
  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))

  (setq lsp-auto-register-remote-clients nil)
  (setq lsp-warn-no-matched-clients nil)
  )

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

;; Arrows on candidates
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
