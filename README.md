# Emacs Configuration

GNU Emacs configuration for software development on GNU/Linux and other POSIX
systems. The configuration lives in the XDG location `~/.config/emacs` and has
been tested with GNU Emacs 31.1. It requires Emacs 29 or later, because it
relies on the built-in `use-package`, `eglot`, `editorconfig`, and `which-key`
packages.

## Installation

The `install-startup-files` script from the
[utility-scripts](https://github.com/mgmorey/utility-scripts) repository clones
this repository into `~/.config/emacs` on a freshly installed host. To install
it by hand, run:

```sh
git clone https://github.com/mgmorey/emacs-config.git ~/.config/emacs
```

Remove or rename any `~/.emacs` file first, because Emacs reads it in
preference to `~/.config/emacs/init.el`.

On first start, `use-package` installs the third-party packages that
`init.el` declares. To install the remaining packages recorded in `custom.el`,
run `M-x package-install-selected-packages`.

## Package Archives

Packages are installed from GNU ELPA and NonGNU ELPA, which Emacs enables by
default, and from MELPA Stable. The development MELPA archive is not used.

## Configured Packages

Built-in packages:

| Package | Configuration |
|---|---|
| `display-line-numbers` | Shows line numbers in programming, text, and configuration buffers. |
| `editorconfig` | Applies `.editorconfig` settings to every buffer. |
| `eglot` | Starts a language server for C and C++ buffers, including the tree-sitter modes. |
| `savehist` | Preserves minibuffer history between sessions. |
| `which-key` | Displays available key bindings after a prefix key. |

Third-party packages:

| Package | Configuration |
|---|---|
| `ace-window` | Replaces `other-window` with numbered window selection. |
| `eterm-256color` | Enables 256-color output in terminal buffers. |
| `markdown-mode` | Edits Markdown with visual line wrapping and a side-by-side preview. |
| `swiper` | Replaces incremental search with an overview of matching lines. |
| `try` | Loads a package for the current session without installing it. |
| `vertico` | Provides a vertical completion interface in the minibuffer. |

`custom.el` additionally records `cmake-mode`, `dockerfile-mode`, `gnuplot`,
`magit`, `modus-themes`, and `yaml-mode`, which are used through their own
default settings.

## Key Bindings

| Key | Context | Command |
|---|---|---|
| `C-c <tab>` | Eglot | `completion-at-point` |
| `C-c C-c r` | Markdown | Create or refresh the side-by-side preview |
| `C-c e f n` | Eglot | `flymake-goto-next-error` |
| `C-c e f p` | Eglot | `flymake-goto-prev-error` |
| `C-c e r` | Eglot | `eglot-rename` |
| `C-r` | Global | `swiper-isearch-backward` |
| `C-s` | Global | `swiper-isearch` |
| `C-x o` | Global | `ace-window` |

## Markdown Preview

`C-c C-c r` renders the current Markdown buffer to HTML with `pandoc` and
displays it in an EWW window to the right. Each Markdown buffer has its own
preview, which is refreshed every time the buffer is saved. The temporary HTML
file is deleted when the Markdown buffer is killed. The preview is styled with
`github-markdown.css`.

## File Associations

`init.el` assigns major modes to file names that Emacs does not recognize by
default, including `.clang-tidy` (YAML), `.env-*` files (configuration),
`.gmk` (Makefile), `.gpi` (gnuplot), `.service` and `.repo` files
(configuration), `Pipfile` and `pylintrc` (configuration), and `Pipfile.lock`
(JSON). C and C++ header files ending in `.h` open in C++ mode.

## External Requirements

The following programs are optional. The related features are unavailable
without them:

- A C and C++ language server, such as `clangd`, for Eglot.
- `pandoc`, for the Markdown preview.

## Contents

| File | Description |
|---|---|
| `.gitignore` | Allowlist of tracked files; all other state in the directory is ignored. |
| `custom.el` | Settings saved by the Emacs Customize interface, including the theme and font. |
| `github-markdown.css` | Style sheet for the Markdown preview. |
| `init.el` | Main configuration. |
| `README.md` | This document. |

The directory also contains state that Emacs creates at run time, such as
installed packages in `elpa/`, minibuffer history, and TRAMP connection data.
The `.gitignore` allowlist keeps that state out of the repository.

## Customize Interface

Emacs rewrites `custom.el` whenever settings are saved through the Customize
interface or the package manager. Because this repository is public, review
`git diff custom.el` before each commit, and keep host names, paths, and
credentials out of the file.
