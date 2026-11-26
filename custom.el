;; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-environment
    '("ASAN_OPTIONS=color=never" "NO_COLOR=1"
       "UBSAN_OPTIONS=color=never:print_stacktrace=1"))
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
    '("967c23e9ba179b80560774419f081df22e7674aac23c5c550b817e4a1ce7d058"
       "7e98dc1aa7f5db0557691da690c38d55e83ddd33c6d268205d66e430d57fb982"
       "6dcf1ca4c7432773084b9d52649ee5eb2c663131c4c06859f648dea98d9acb3e"
       "77f281064ea1c8b14938866e21c4e51e4168e05db98863bd7430f1352cab294a"
       "6fbe13f5f21eb3e959edfaa0185301d15309224116cc5e6f0ab3b2a40ee3bd3b"
       "2e7dc2838b7941ab9cabaa3b6793286e5134f583c04bde2fba2f4e20f2617cf7"
       default))
 '(enable-recursive-minibuffers t)
 '(package-selected-packages
    '(ace-window cmake-font-lock cmake-ide cmake-mode cmake-project dape
       docker docker-cli dockerfile-mode editorconfig
       editorconfig-custom-majormode eglot eterm-256color gnuplot
       json-mode magit markdown-mode modus-themes swiper try vertico
       yaml-mode))
 '(safe-local-variable-values
    '((eval let*
        ((preset
           (cond
             ((file-remote-p default-directory) "ubuntu-x64-debug")
             ((eq system-type 'darwin) "macos-arm64-debug")
             ((eq system-type 'gnu/linux) "ubuntu-x64-debug")
             (t (error "No CMake preset for %s" system-type))))
          (build-dir (concat "build-cmake/" preset)))
        (setq-local compile-command
          (format "cmake --build --preset %s --parallel" preset))
        (setq-local dape-command
          `(gdb defer-launch-attach t :program
             ,(concat build-dir "/unix-server")))
        (setq-local eglot-server-programs
          `
          (((c++-mode c++-ts-mode) "clangd"
             ,(concat "--compile-commands-dir=" build-dir)))))
       (dape-command gdb defer-launch-attach t :program
         "build-cmake/ubuntu-x64-debug/unix-server")
       (cmake-tab-width . 8)
       (eglot-server-programs
         ((c++-mode c++-ts-mode) "clangd"
           "--compile-commands-dir=build-cmake/ubuntu-x64-debug"))
       (make-backup-files) (cmake-tab-width . 4)))
 '(sh-indent-after-continuation t)
 '(shr-use-fonts t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight medium :height 120 :width normal)))))
