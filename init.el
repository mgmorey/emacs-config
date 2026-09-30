;; -*- lexical-binding: t; -*-
(add-to-list 'load-path "~/.emacs.d/elisp/")

;; ;; Workaround for https://debbugs.gnu.org/34341
;; (setq gnutls-algorithm-priority "normal:-vers-tls1.3")

(when (> emacs-major-version 22)
  (require 'package)

  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                   (not (gnutls-available-p))))
          (proto (if no-ssl "http" "https")))
    ;; ;; Comment/uncomment the next two statements to enable/disable
    ;; ;; MELPA and MELPA Stable as desired
    ;; (add-to-list 'package-archives
    ;;   (cons "melpa"
    ;;     (concat proto "://melpa.org/packages/")) t)
    (add-to-list 'package-archives
      (cons "melpa-stable"
        (concat proto "://stable.melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
      ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives
        '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

  ;; Added by Package.el.  This must come before configurations of
  ;; installed packages.  Don't delete this line.  If you don't want it,
  ;; just comment it out by adding a semicolon to the start of the line.
  ;; You may delete these explanatory comments.
  (package-initialize)

  ;; Refresh package contents
  (unless package-archive-contents
    (package-refresh-contents))

  ;; ;; Configure apex-mode
  ;; (require 'apex-mode)

  ;; ;; Configure company
  ;; (require 'company)
  ;; (add-hook 'after-init-hook 'global-company-mode)

  ;; ;; Configure counsel
  ;; (require 'counsel)
  ;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  ;; ;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
  ;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  ;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  ;; (global-set-key (kbd "<f2> j") 'counsel-set-variable)
  ;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  ;; (global-set-key (kbd "C-c F") 'counsel-org-file)
  ;; (global-set-key (kbd "C-c b") 'counsel-bookmark)
  ;; (global-set-key (kbd "C-c c") 'counsel-compile)
  ;; (global-set-key (kbd "C-c d") 'counsel-descbinds)
  ;; (global-set-key (kbd "C-c g") 'counsel-git)
  ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
  ;; (global-set-key (kbd "C-c o") 'counsel-outline)
  ;; (global-set-key (kbd "C-c t") 'counsel-load-theme)
  ;; ;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  ;; (global-set-key (kbd "M-x") 'counsel-M-x)
  ;; (global-set-key (kbd "M-y") 'counsel-yank-pop)

  ;; ;; Configure counsel-tags
  ;; (require 'counsel-etags)
  ;; (global-set-key (kbd "M-.") 'counsel-etags-find-tag-at-point)

  ;; ;; Configure discover
  ;; (require 'discover)
  ;; (global-discover-mode 1)

  ;; Configure display-line-numbers
  (require 'display-line-numbers)
  (defcustom display-line-numbers-exempt-modes
    '(Dired-mode Info-mode Man-mode ansi-term-mode compilation-mode
       eshell-mode package-menu-mode shell-mode term-mode vterm-mode)
    "Major modes on which to disable line numbers."
    :group 'display-line-numbers
    :type 'list
    :version "green")
  (defun display-line-numbers--turn-on ()
    "Turn on line numbers except for certain major modes.
  Exempt major modes are defined in `display-line-numbers-exempt-modes'."
    (unless (or (minibufferp)
              (member major-mode display-line-numbers-exempt-modes))
      (display-line-numbers-mode)))
  (global-display-line-numbers-mode)

  ;; ;; Configure docker-cli
  ;; (require 'docker-cli)

  ;; Configure editorconfig-mode
  (require 'editorconfig)
  (editorconfig-mode 1)

  ;; Configure ECB
  (require 'ecb-autoloads)

  ;; Configure eglot
  (require 'eglot)
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (define-key eglot-mode-map (kbd "C-c <tab>") #'company-complete)
  (define-key eglot-mode-map (kbd "C-c e f n") #'flymake-goto-next-error)
  (define-key eglot-mode-map (kbd "C-c e f p") #'flymake-goto-prev-error)
  (define-key eglot-mode-map (kbd "C-c e r") #'eglot-rename)

  ;; ;; Configure helm-mode
  ;; (require 'helm-config)
  ;; (helm-mode 1)

  ;; ;; Configure ivy
  ;; (require 'ivy)
  ;; (ivy-mode 1)
  ;; (setq ivy-count-format "(%d/%d) ")
  ;; (setq ivy-use-virtual-buffers t)
  ;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
  ;; (global-set-key (kbd "C-c V") 'ivy-pop-view)
  ;; (global-set-key (kbd "C-c v") 'ivy-push-view)
  ;; (global-set-key (kbd "C-x b") 'ivy-switch-buffer)

  ;; ;; Configure mmm-mode
  ;; (require 'mmm-mode)
  ;; (setq mmm-global-mode 'maybe)
  ;; (mmm-add-mode-ext-class nil "\\.php\\'" 'html-php)
  ;; (mmm-add-classes
  ;;  '((html-php
  ;;     :submode php-mode
  ;;     :front "<\\?\\(php\\)?"
  ;;     :back "\\?>")))
  ;; (autoload 'php-mode "php-mode" "PHP editing mode" t)
  ;; (add-to-list 'auto-mode-alist '("\\.php\\'" . html-mode))

  ;; ;; Configure modus-themes
  ;; (require 'modus-themes)
  ;; ;; Add all your customizations prior to loading the themes
  ;; (setq modus-themes-italic-constructs t
  ;;   modus-themes-bold-constructs t
  ;;   modus-themes-region '(bg-only no-extend))
  ;; ;; ;; Load the theme files before enabling a theme
  ;; ;; (modus-themes-load-themes)
  ;; ;; ;; Load the theme of your choice:
  ;; ;; (modus-themes-load-operandi) ;; OR (modus-themes-load-vivendi)
  ;; (define-key global-map (kbd "<f5>") #'modus-themes-toggle)

  ;; ;; Configure paredit
  ;; (require 'paredit)
  ;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  ;; (add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
  ;; (add-hook 'ielm-mode-hook 'enable-paredit-mode)
  ;; (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  ;; (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  ;; (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  ;; (defun override-slime-del-key ()
  ;;   (define-key slime-repl-mode-map
  ;;     (read-kbd-macro paredit-backward-delete-key) nil))
  ;; (add-hook 'slime-repl-mode-hook 'override-slime-del-key)

  ;; ;; Configure slime
  ;; (require 'slime)
  ;; (require 'slime-autoloads)
  ;; (setq inferior-lisp-program "sbcl")
  ;; (setq slime-contribs '(slime-fancy))

  ;; Configure swiper
  (require 'swiper)
  (global-set-key (kbd "C-s") 'swiper-isearch)
  (global-set-key (kbd "C-r") 'swiper-isearch-backward)

  ;; Bootstrap use-package
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)

  (use-package ace-window
    :ensure t
    :init
    (progn
      (global-set-key [remap other-window] 'ace-window)
      (custom-set-faces
        '(aw-leading-char-face
           ((t (:inherit ace-jump-face-foreground :height 3.0)))))
      ))

  (use-package eterm-256color
    :ensure t
    :hook (term-mode . eterm-256color-mode))

  ;; (use-package lsp-mode
  ;;   :commands (lsp lsp-deferred)
  ;;   :config
  ;;   (lsp-enable-which-key-integration t)
  ;;   :hook ((c++-mode python-mode) . lsp-deferred)
  ;;   :init
  ;;   (setq lsp-keymap-prefix "C-c l"))

  ;; (use-package lsp-ui
  ;;   :commands lsp-ui-mode
  ;;   :config
  ;;   (setq lsp-ui-doc-enable nil)
  ;;   (setq lsp-ui-doc-header t)
  ;;   (setq lsp-ui-doc-include-signature t)
  ;;   (setq lsp-ui-doc-border (face-foreground 'default))
  ;;   (setq lsp-ui-sideline-show-code-actions t)
  ;;   (setq lsp-ui-sideline-delay 0.05))

  (use-package markdown-mode
    :ensure t
    :mode ("\\.md\\'" . markdown-mode)
    :hook (markdown-mode . visual-line-mode)
    :config

    ;; Use pandoc for Markdown ? HTML
    (setq markdown-command "pandoc")

    ;; Buffer-local preview file
    (defvar-local my/markdown-preview-file nil
      "Path to the current Markdown preview HTML file.")

    ;; Main preview function
    (defun my/markdown-preview-side-by-side ()
      "Create or refresh Markdown preview without resetting layout."
      (interactive)

      ;; Create preview file once per buffer
      (unless my/markdown-preview-file
        (setq my/markdown-preview-file
          (make-temp-file "md-preview" nil ".html")))

      (save-buffer)

      ;; Generate HTML via pandoc
      (call-process
        "pandoc" nil nil nil
        "-f" "gfm"
        "-t" "html5"
        "--standalone"
        "--metadata=title:Preview"
        "--highlight-style=pygments"
        "--css" (concat (getenv "HOME")
                  "/.config/emacs/github-markdown.css")
        "-o" my/markdown-preview-file
        buffer-file-name)

      ;; Refresh existing preview or create it once
      (if-let* ((win (get-buffer-window "*eww*")))
        (with-selected-window win
          (eww-reload))
        (let ((preview-window (split-window-right)))
          (with-selected-window preview-window
            (eww-open-file my/markdown-preview-file)))))

    ;; Auto-refresh on save (buffer-local)
    (defun my/markdown-auto-refresh ()
      (when (and my/markdown-preview-file
              (derived-mode-p 'markdown-mode))
        (my/markdown-preview-side-by-side)))

    (add-hook 'markdown-mode-hook
      (lambda ()
        (add-hook 'after-save-hook
          #'my/markdown-auto-refresh
          nil t)))

    ;; Keybinding
    (define-key markdown-mode-map (kbd "C-c C-p")
      #'my/markdown-preview-side-by-side))

  ;; (use-package modus-themes
  ;;   :ensure
  ;;   :init
  ;;   ;; Add all your customizations prior to loading the themes
  ;;   (setq modus-themes-italic-constructs t
  ;;     modus-themes-bold-constructs t
  ;;     modus-themes-region '(bg-only no-extend))
  ;;   ;; Load the theme files before enabling a theme
  ;;   (modus-themes-load-themes)
  ;;   :config
  ;;   ;; Load the theme of your choice:
  ;;   (modus-themes-load-operandi) ;; OR (modus-themes-load-vivendi)
  ;;   :bind ("<f5>" . modus-themes-toggle))

  ;; (use-package projectile
  ;;   :bind-keymap
  ;;   ("C-c p" . projectile-command-map)
  ;;   :ensure t
  ;;   :config (projectile-mode)
  ;;   :diminish projectile-mode
  ;;   :init
  ;;   (when (file-directory-p "~/git")
  ;;     (setq project-project-search-path '("~/git")))
  ;;   (setq projectile-switch-project-action #'projectile-dired))

  (use-package savehist
    :ensure t
    :init
    (savehist-mode))

  (use-package try
    :ensure t)

  (use-package vertico
    :ensure t
    :init
    (vertico-mode))

  (use-package which-key
    :config (which-key-mode)
    :ensure t)

  ;; ;; Configure for macOS
  ;; (setq insert-directory-program "gls" dired-use-ls-dired t)
  ;; (setq mac-command-modifier 'meta)
  ;; (setq mac-option-modifier 'control)

  ;; ;; Configure PHP/Web mode toggle
  ;; (defun toggle-php-flavor-mode ()
  ;;   (interactive)
  ;;   "Toggle between PHP- and Web-Mode Helper modes"
  ;;   (cond ((eq major-mode 'php-mode)
  ;;          (web-mode))
  ;;         ((eq major-mode 'web-mode)
  ;;          (php-mode))))

  ;; ;; Set global keybindings
  ;; (global-set-key [f5] 'toggle-php-flavor-mode)
  (global-set-key (kbd "C-x g") 'magit-status)
  )

;; ;; Configure input-decode-map
;; (defun terminal-init-screen ()
;;   "Terminal initialization function for GNU screen."
;;   (when (boundp 'input-decode-map)
;;     (define-key input-decode-map "^[[1;5C" [(control right)])
;;     (define-key input-decode-map "^[[1;5D" [(control left)])))

;; Default to indenting with spaces (rather than tabs)
(setq-default indent-tabs-mode nil)

;; Set C default style
(setq c-default-style "bsd")

;; ;; Customize Emacs splash image
;; (setq fancy-splash-image "~/.config/emacs/images/Emacs-logo.png")

;; ;; Enable Global Auto-Revert Mode
;; (global-auto-revert-mode 1)

;; ;; Enable Recent File Mode
;; (recentf-mode 1)

;; ;; Enable Save Place Mode
;; (save-place-mode 1)

;; ;; Enable Which Function Mode
;; (which-function-mode)

;; Override default major mode according to file name pattern
(add-to-list 'auto-mode-alist '("Containerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("Pipfile.lock\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("Pipfile\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.clang-tidy\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.env-.+\\'" . dotenv-mode))
(add-to-list 'auto-mode-alist '("\\.fish\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gmk\\'" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.gpi\\'" . gnuplot-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.lst\\'" . fundamental-mode))
(add-to-list 'auto-mode-alist '("\\.pylintrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.repo\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("pylintrc\\'" . conf-mode))

;; Change the location of customizations (variables and faces)
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)
