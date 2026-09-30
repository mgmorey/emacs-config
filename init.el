;; -*- lexical-binding: t; -*-

;; Load Custom settings (theme, font) first so they apply before the rest of init
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq use-package-always-ensure t)

;;; Built-in packages

(use-package display-line-numbers
  :ensure nil
  :hook ((prog-mode text-mode conf-mode) . display-line-numbers-mode))

(use-package editorconfig
  :ensure nil
  :config (editorconfig-mode 1))

(use-package eglot
  :ensure nil
  :hook ((c-mode c++-mode c-ts-mode c++-ts-mode) . eglot-ensure)
  :bind (:map eglot-mode-map
          ("C-c <tab>" . completion-at-point)
          ("C-c e f n" . flymake-goto-next-error)
          ("C-c e f p" . flymake-goto-prev-error)
          ("C-c e r" . eglot-rename)))

(use-package savehist
  :ensure nil
  :init (savehist-mode))

(use-package which-key
  :ensure nil
  :config (which-key-mode))

;;; Third-party packages

(use-package ace-window
  :bind ([remap other-window] . ace-window)
  :custom-face
  (aw-leading-char-face ((t (:height 3.0)))))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package swiper
  :bind (("C-s" . swiper-isearch)
          ("C-r" . swiper-isearch-backward)))

(use-package try)

(use-package vertico
  :init (vertico-mode))

;;; Markdown with a side-by-side pandoc/eww preview

(defvar-local my/markdown-preview-file nil
  "Path to this Markdown buffer's preview HTML file.")

(defvar-local my/markdown-preview-buffer nil
  "The eww buffer showing this Markdown buffer's preview.")

(defun my/markdown-preview-cleanup ()
  "Delete this buffer's preview HTML file."
  (when (and my/markdown-preview-file
          (file-exists-p my/markdown-preview-file))
    (delete-file my/markdown-preview-file)))

(defun my/markdown-preview-side-by-side ()
  "Create or refresh the Markdown preview without resetting the layout."
  (interactive)
  (unless my/markdown-preview-file
    (setq my/markdown-preview-file
      (make-temp-file "md-preview" nil ".html"))
    (add-hook 'kill-buffer-hook #'my/markdown-preview-cleanup nil t))
  (save-buffer)
  (let ((errors (get-buffer-create " *markdown-preview-pandoc*")))
    (with-current-buffer errors (erase-buffer))
    (unless (eq 0 (call-process
                    "pandoc" nil errors nil
                    "-f" "gfm"
                    "-t" "html5"
                    "--standalone"
                    "--metadata=title:Preview"
                    "--highlight-style=pygments"
                    "--css" (expand-file-name "github-markdown.css"
                              user-emacs-directory)
                    "-o" my/markdown-preview-file
                    buffer-file-name))
      (user-error "pandoc failed: %s"
        (with-current-buffer errors (string-trim (buffer-string))))))
  (let* ((file my/markdown-preview-file)
          (buf my/markdown-preview-buffer)
          (win (and (buffer-live-p buf) (get-buffer-window buf))))
    (cond
      (win
        (with-selected-window win (eww-reload)))
      ((buffer-live-p buf)
        (with-selected-window (split-window-right)
          (switch-to-buffer buf)
          (eww-reload)))
      (t
        (with-selected-window (split-window-right)
          (eww-open-file file t)
          (setq buf (current-buffer)))
        (setq my/markdown-preview-buffer buf)))))

(defun my/markdown-auto-refresh ()
  "Refresh the preview on save once it has been opened."
  (when my/markdown-preview-file
    (my/markdown-preview-side-by-side)))

(defun my/markdown-enable-auto-refresh ()
  (add-hook 'after-save-hook #'my/markdown-auto-refresh nil t))

(use-package markdown-mode
  :hook ((markdown-mode . visual-line-mode)
          (markdown-mode . my/markdown-enable-auto-refresh))
  :bind (:map markdown-mode-command-map
          ("r" . my/markdown-preview-side-by-side))
  :custom (markdown-command "pandoc"))

;;; General editing

(setq-default indent-tabs-mode nil)

(setq c-default-style
  '((java-mode . "java") (awk-mode . "awk") (other . "bsd")))

;; Override default major mode according to file name pattern
(add-to-list 'auto-mode-alist '("Pipfile\\.lock\\'" . js-json-mode))
(add-to-list 'auto-mode-alist '("Pipfile\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.clang-tidy\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.env-.+\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.fish\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gmk\\'" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.gpi\\'" . gnuplot-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.lst\\'" . fundamental-mode))
(add-to-list 'auto-mode-alist '("\\.repo\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("pylintrc\\'" . conf-mode))
