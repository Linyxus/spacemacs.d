;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/Dotfiles/abgruszecki-spacemacs-private/")

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(vimscript
     shell-scripts
     (lsp :variables
          default-nix-wrapper (lambda (args)
                                (append
                                 (append (list "nix-shell" "-I" "." "--command" )
                                         (list (mapconcat 'identity args " ")))
                                 (list (nix-current-sandbox))))
          haskell-nix-wrapper (lambda (args)
                                (apply default-nix-wrapper (list (append args (list "--ghc-option" "-Wwarn")))))
          lsp-haskell-process-wrapper-function default-nix-wrapper
          haskell-process-wrapper-function haskell-nix-wrapper
          )
     (deft :variables deft-zetteldeft t)
     (scala :variables
            scala-backend 'scala-metals
            scala-auto-treeview nil
            scala-sbt-window-position 'bottom)
     dotty
     coq
     agda
     ;; python
     (go :variables go-tab-width 4)
     restructuredtext
     html
     (spell-checking :variables spell-checking-enable-by-default nil)
     (wakatime :variables
               wakatime-api-key "d9394843-0d9e-4a27-bc18-e231ba94d41b"
               wakatime-cli-path "/opt/homebrew/bin/wakatime-cli")
     (elm :variables
          elm-format-on-save t)
     (rust :variables
           lsp-rust-server 'rust-analyzer)
     javascript
     yaml
     (c-c++ :variables
            c-c++-backend 'lsp-ccls
            c-c++-lsp-enable-semantic-highlight t)
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; ivy
     ;; osx
     ;; themes-megapack
     ;; helm
     ivy
     racket
     auto-completion
     ;; better-defaults
     emacs-lisp
     (haskell :variables
              haskell-completion-backend 'lsp)
     git
     ;; (markdown :variables markdown-live-preview-engine 'eww)
     (org :variables
          org-enable-hugo-support t
          org-enable-valign t)
     (latex :variables
            latex-backend 'lsp
            latex-build-engine 'luatex
            latex-view-with-pdf-tools t
            latex-view-pdf-in-split-window t)
     semantic
     (shell :variables
            shell-default-shell 'vterm
            shell-default-height 30
            shell-default-position 'bottom)
     ;; spell-checking
     syntax-checking
     ;; version-control
     caddyfile

     (neotree :variables neo-theme 'nerd)

     emoji
     pdf

     ;; eaf

     ;; chinese

     bibtex

     finance
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(color-theme-sanityinc-tomorrow sublimity direnv nix-sandbox gruvbox-theme ef-themes
                                                                     (fantom-theme :location (recipe :fetcher github :repo "linyxus/fantom-emacs-theme"))
                                                                     (minimal-theme :location (recipe :fetcher github :repo "anler/minimal-theme"))
                                                                     verilog-mode centered-window snazzy-theme org-timeline nord-theme modus-themes standard-themes
                                                                     (qrhl-input :location local)
                                                                     telega)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 10)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         nord
                         modus-vivendi
                         modus-operandi
                         ;; standard-light
                         ;; standard-dark
                         gruvbox-dark-hard
                         fantom
                         snazzy
                         sanityinc-tomorrow-eighties
                         sanityinc-tomorrow-day
                         )

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("JuliaMono"
                               :size 11
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; dotspacemacs-mode-line-theme 'vim-powerline
   dotspacemacs-mode-line-theme 'spacemacs
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers 'visual
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%a (%p) - %S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfer with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq evil-want-abbrev-expand-on-insert-exit nil)

  ;; (setq telega-server-libs-prefix "/opt/homebrew")

  ;; (setq configuration-layer-elpa-archives
  ;;   '(("melpa-cn"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
  ;;     ("org-cn"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
  ;;     ("gnu-cn"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
  ;;     ("nongnu-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (setq initial-buffer-choice (lambda () (get-buffer "*scratch*")))

  (with-eval-after-load 'latex
    (add-hook 'TeX-mode-hook 'wakatime-mode)
    )

  (with-eval-after-load 'undo-tree
    (setq undo-tree-auto-save-history nil))

  (setq c-basic-offset 4)
  (add-hook 'dante-mode-hook 'flycheck-mode)
  (setq mac-command-modifier 'meta)
  ;; (setq mac-option-modifier 'super)

  ;; (require 'sublimity)
  ;; (require 'sublimity-scroll)
  ;; (sublimity-mode 1)

  (setq-default line-spacing 6)
  (load-file "~/.spacemacs.d/layers/agda-input.el")

  ;; Enable emacs-mac's ligature mode for all prog-mode
  ;; (add-hook 'prog-mode-hook 'mac-auto-operator-composition-mode)
  ;; (spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hook-racket-mode)

  ;; Hledger
  (setq ledger-mode-should-check-version nil
        ledger-report-links-in-register nil
        ledger-binary-path "hledger")

  (with-eval-after-load 'ledger-mode
    (setq-default ledger-reports
                  '(("last_months" "%(binary) balance expenses --tree --no-total --row-total --average --monthly --begin '6 months ago'")
                    ("this_month" "%(binary) balance expenses --tree --no-total --row-total --average --monthly --begin 'this month'")
                    ("this_week" "%(binary) balance expenses --tree --no-total --row-total --average --daily --begin 'this week'")
                    ("weekly" "%(binary) balance expenses --tree --no-total --row-total --average --weekly --begin '4 weeks ago'")
                    ("weekly (more)" "%(binary) balance expenses --tree --no-total --row-total --average --weekly --begin '10 weeks ago'")
                    ("daily" "%(binary) balance expenses --tree --no-total --row-total --average --daily --begin '5 days ago'")
                    ("all_assets" "%(binary) balance assets liabilities --tree")))
    (setq-default ledger-report-auto-width nil)
    (setq-default ledger-report-use-native-highlighting nil))

  (with-eval-after-load 'org
    ;; Enable org-indent mode in org-mode
    (add-hook 'org-mode-hook 'org-indent-mode)
    (setq org-agenda-files '("~/org/gtd.org"
                            "~/org/inbox.org"
                            "~/org/books.org"
                            "~/org/tickler.org"))
    ;; Startup org agenda views in current window defaultly
    (setq-default org-agenda-window-setup 'current-window)
    ;; Always rebuild agenda views
    (setq org-agenda-sticky nil)
    (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                  (file+headline "~/org/inbox.org" "Tasks")
                                  "* TODO %i%?")
                                  ("i" "Tickler" entry
                                  (file+headline "~/org/tickler.org" "Tickler")
                                  "* %i%? \n %U")
                                  ("h" "Homework [inbox]" entry
                                  (file+headline "~/org/inbox.org" "Homework")
                                  "* HOMEWORK %i%?")))
    (setq org-refile-targets '(("~/org/gtd.org" :maxlevel . 3)
                              ("~/org/someday.org" :level . 1)
                              ("~/org/books.org" :level . 2)
                              ("~/org/tickler.org" :maxlevel . 2)))
    (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(o)" "CHECK(e)" "PROJECT(p)" "|" "DONE(d)" "CANCELLED(cc)" "SPLITTED(sp)")
                              (sequence "HOMEWORK(h)" "FINISHED(f)" "|" "SUBMITTED(sb)")
                              (sequence "BOOK(b)" "READING(r)" "CHAP(ch)" "|" "READ(a)")
                              ))
    (setq org-agenda-custom-commands
          '(("c" "Learning courses" tags-todo "@course"
            ((org-agenda-overriding-header "Course")))
            ("r" "Doing research" tags-todo "@research"
            ((org-agenda-overriding-header "Research")))
            ("i" "Reading books" tags-todo "@book"
            ((org-agenda-overriding-header "Book")))
            ("o" "Task view"
            ((agenda "plain" ((org-agenda-span 'day) (org-agenda-overriding-header "Today")))
              (tags-todo "@course" ((org-agenda-overriding-header "@course")))
              (tags-todo "@research" ((org-agenda-overriding-header "@research")))
              (tags-todo "@miscs" ((org-agenda-overriding-header "@miscs")))))))

    ;; org latex packages
    ;; (add-to-list 'org-latex-packages-alist '("" "booktabs"))

    ;; Enable visual-line-mode in org-mode
    (add-hook 'org-mode-hook 'visual-line-mode)
    ;; Enable org-clock in mode line
    (spacemacs/toggle-mode-line-org-clock-on)

    ;; scale up LaTeX previews
    (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
    )


  ;; Enable visual-line-mode in Coq-mode
  (add-hook 'coq-mode-hook 'visual-line-mode)

  ;; Enable org-timeline in agenda views
  ;; (require org-timeline)
  ;; (add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)

  ;; Enable dante while using lsp (for REPLoid)
  ;; (add-hook 'lsp-mode-hook 'dante-mode)

  ;; Disable company-mode in eshell to avoid hanging up
  (defun disable-company-mode ()
    (company-mode 0))
  (add-hook 'eshell-mode-hook #'disable-company-mode)

  (setq lsp-verilog-server-path "~/.pyenv/versions/3.8.2/bin/hdl_checker")
  (custom-set-variables '(lsp-verilog-server 'hdl-checker))
  (add-hook 'verilog-mode-hook 'lsp)

  ;; Configure Deft
  ;; (setq-default deft-directory "/Users/linyxus/deft")

  ;; Configure scalastyle
  (setq-default flycheck-scalastylerc "~/.config/scalastyle/scalastyle_config.xml")

  ;; Configure magit
  (setq-default git-magit-status-fullscreen t)

  ;; Use rg for helm-ag
  ;; (setq-default helm-ag-base-command "rg --vimgrep --no-heading --smart-case")
  (setq-default counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s || true")

  ;; Telega
  (setq telega-proxies '((:server "127.0.0.1" :port 7890 :enable t :type (:@type "proxyTypeHttp" :username "" :password "" :http_only :false))))

  ;; direnv
  ;; (require 'direnv)
  ;; (direnv-mode)

  ;; bibtex
  (setq bibtex-completion-bibliography "~/.papiers/bundle.bib"
        bibtex-completion-library-path "~/.papiers/"
        bibtex-completion-pdf-field "pdf"
        bibtex-completion-notes-path "~/.papiers/notes.org")
  (setq bibtex-completion-pdf-open-function
        (lambda (fpath)
          (call-process "open" nil 0 nil "-a" "/Applications/PDF Expert.app" fpath)))
  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine 'xetex)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(beacon-color "#f2777a")
 '(connection-local-criteria-alist
   '(((:application eshell)
      eshell-connection-default-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile)
     ((:application tramp :machine "localhost")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp :machine "Yichens-MacBook-Pro.local")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile
      (eshell-path-env-list))
     (tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(custom-safe-themes
   '("8b930a6af47e826c12be96de5c28f1d142dccab1927f196589dafffad0fc9652" "4b92d689600e9851d098c73951f7075f8fd0bb705b4d68806305cf3e4f001c9e" "75441a94fb5e6943320ce21aa5acf9cb24c3f87915666800f3906af8e85e0892" "84c2c93ce268699838b51eeeaaec46e064d5048e232b39113b73209be3ef6fd4" "72cc2c6c5642b117034b99dcc3a33ff97a66593429c7f44cd21b995b17eebd4e" "544bb10f6c6d7338be3bc73d147f26273d62e094e7643bfa842dffa9d742e30a" "6a94122cfa72865c9b7a211ee461e4cc8834451d035fb43ffa478a630dec3d5b" "cd65fad3243fb2b04660fb5c56152e27030e904b5f06b743bb77cac85c5327b7" "9fad628c15f1e94af44e07b00ebe3c15109be28f4d73adf4a9e22090845cbce9" "279f74e365ba5aade8bc702e0588f0c90b5dee6cf04cf61f9455661700a6ebeb" "3199be8536de4a8300eaf9ce6d864a35aa802088c0925e944e2b74a574c68fd0" "7dc296b80df1b29bfc4062d1a66ee91efb462d6a7a934955e94e786394d80b71" "f8e86823197cb9f48666c36734ce73543e6a9b3101282eae8b430ef93be16ccf" "41c478598f93d62f46ec0ef9fbf351a02012e8651e2a0786e0f85e6ac598f599" "b0b76d75c85dce0bb0c6db786bb73bafa4e74caea101d8653a2fc6cde3e3a4d4" "fb3f55ac1ca4d5ba0d35b5507e28fa392b59e796a40d25497b23fd857892f74d" "5612c4b573b3f3b9e3763ce45e29f5c45083c0742be1a9d62193e840cd51eb75" "81406f2e0fd3424aaf89dcf41ce50526784561129bd8fc5e11d55655931e75e6" "5d7bf3ce124535c2415b69c7e017a6258150a11cdfc3029b53310ff50e794967" "33cd1d4d57fdad620c7578ddf7372acb9a7ea106903c152b06781f8554b8e4c9" "e128dc48a4d4754c529057713bfe215fbad0c851e8cb4ecc2e41997a6950dc33" "47d2c2996ec0d4a0f6562d1f06b8f27ed2dec9504f6021d83ae082face3246cd" "d97092d4087a2a1455121ad6ff299130083853ba3c4c6b325685a59d68f8e596" "2e59c24f4daea67be42e30f1e9b40b3169708c5dc97c55e94347380be783499b" "88550f210943832ace0ab1655c541f3912ceaab30e83843682d623c6808502ad" "4780d7ce6e5491e2c1190082f7fe0f812707fc77455616ab6f8b38e796cbffa9" "3e335d794ed3030fefd0dbd7ff2d3555e29481fe4bbb0106ea11c660d6001767" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" "795d2a48b56beaa6a811bcf6aad9551878324f81f66cac964f699871491710fa" "e27c391095dcee30face81de5c8354afb2fbe69143e1129109a16d17871fc055" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "264b639ee1d01cd81f6ab49a63b6354d902c7f7ed17ecf6e8c2bd5eb6d8ca09c" "34ed3e2fa4a1cb2ce7400c7f1a6c8f12931d8021435bad841fdc1192bd1cc7da" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" "3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "2c613514f52fb56d34d00cc074fe6b5f4769b4b7f0cc12d22787808addcef12c" "c0a0c2f40c110b5b212eb4f2dad6ac9cac07eb70380631151fa75556b0100063" "efc8341e278323cd87eda7d7a3736c8837b10ebfaa0d2be978820378d3d1b2e2" "9283fa483ecced7578f97fdad451535b0173d770b2f433ad0e700decc118ab91" "65ef77d1038e36cb9dd3f514d86713f8242cb1352f5ebf0d2390c7e5bf1fd4d1" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "922e96b74620a11b52434d551cf7115b8274dfa42b289eeec44d93378d0bf093" default))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#515151" t)
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(helm-completion-style 'emacs)
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(ledger-reports
   '(("all_assets" "hledger [[ledger-mode-flags]] balance assets liabilities --tree")
     ("last_months" "%(binary) balance expenses --tree --no-total --row-total --average --monthly --begin '3 months ago'")
     ("this_month" "%(binary) balance expenses --tree --no-total --row-total --average --monthly --begin 'this month'")
     ("this_week" "%(binary) balance expenses --tree --no-total --row-total --average --daily --begin 'this week'")))
 '(lsp-haskell-server-path "haskell-language-server-wrapper")
 '(lsp-verilog-server 'hdl-checker)
 '(org-latex-classes
   '(("ctexbeamer" "\\documentclass[UTF8]{ctexbeamer}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("beamer" "\\documentclass[presentation]{beamer}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
 '(org-preview-latex-default-process 'dvisvgm)
 '(package-selected-packages
   '(standard-themes night-owl-theme ef-themes telega texfrag vimrc-mode helm-gtags ggtags dactyl-mode counsel-gtags yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify wakatime-mode volatile-highlights vi-tilde-fringe uuidgen use-package undo-tree toml-mode toc-org tagedit sublimity stickyfunc-enhance srefactor spaceline powerline slim-mode shell-pop scss-mode scala-mode sbt-mode sass-mode restart-emacs request rainbow-delimiters racket-mode racer pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pcre2el paradox spinner org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-plus-contrib org-mime org-download org-bullets open-junk-file noflet nix-sandbox neotree multi-term move-text mmm-mode markdown-toc macrostep lorem-ipsum livid-mode skewer-mode simple-httpd live-py-mode linum-relative link-hint json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc intero insert-shebang indent-guide hydra lv hy-mode dash-functional hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile projectile helm-mode-manager helm-make helm-hoogle helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets haml-mode google-translate golden-ratio go-guru go-eldoc gnuplot gh-md fuzzy flycheck-rust flycheck-pos-tip pos-tip flycheck-haskell flycheck-elm flycheck pkg-info epl flx-ido flx fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elm-mode reformatter elisp-slime-nav dumb-jump disaster direnv diminish deft define-word cython-mode company-web web-completion-data company-statistics company-shell company-go go-mode company-ghci company-ghc ghc haskell-mode company-cabal company-c-headers company-auctex company-anaconda company column-enforce-mode color-theme-sanityinc-tomorrow coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format centered-window cargo markdown-mode rust-mode caddyfile-mode loop bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-compile packed auctex anaconda-mode pythonic f dash s aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup fantom-theme))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(safe-local-variable-values
   '((eval turn-off-auto-fill)
     (lsp-enabled-clients quote
                          (scala3ls))
     (haskell-completion-backend . ghci)
     (javascript-backend . tide)
     (javascript-backend . tern)
     (javascript-backend . lsp)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99")))
 '(vc-annotate-very-old-color nil)
 '(wakatime-python-bin nil)
 '(warning-suppress-types '((comp)))
 '(window-divider-mode nil)
 '(yas-snippet-dirs
   '("/Users/linyxus/.emacs.d/private/snippets/" "/Users/linyxus/.emacs.d/layers/+completion/auto-completion/local/snippets" "/Users/linyxus/.spacemacs.d/snippets/" yasnippet-snippets-dir)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t))
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   '(yapfify yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify wakatime-mode volatile-highlights vi-tilde-fringe uuidgen use-package undo-tree toml-mode toc-org tagedit sublimity stickyfunc-enhance srefactor spaceline powerline slim-mode shell-pop scss-mode scala-mode sbt-mode sass-mode restart-emacs request rainbow-delimiters racket-mode racer pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pcre2el paradox spinner org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-plus-contrib org-mime org-download org-bullets open-junk-file noflet nix-sandbox neotree multi-term move-text mmm-mode markdown-toc macrostep lorem-ipsum livid-mode skewer-mode simple-httpd live-py-mode linum-relative link-hint json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc intero insert-shebang indent-guide hydra lv hy-mode dash-functional hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile projectile helm-mode-manager helm-make helm-hoogle helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets haml-mode google-translate golden-ratio go-guru go-eldoc gnuplot gh-md fuzzy flycheck-rust flycheck-pos-tip pos-tip flycheck-haskell flycheck-elm flycheck pkg-info epl flx-ido flx fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elm-mode reformatter elisp-slime-nav dumb-jump disaster direnv diminish deft define-word cython-mode company-web web-completion-data company-statistics company-shell company-go go-mode company-ghci company-ghc ghc haskell-mode company-cabal company-c-headers company-auctex company-anaconda company column-enforce-mode color-theme-sanityinc-tomorrow coffee-mode cmm-mode cmake-mode clean-aindent-mode clang-format centered-window cargo markdown-mode rust-mode caddyfile-mode loop bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-compile packed auctex anaconda-mode pythonic f dash s aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup fantom-theme)))
