{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "danielm";
  home.homeDirectory = "/Users/danielm";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Shell & terminal
    bash
    nushell
    oh-my-posh
    zoxide
    fzf
    broot
    btop
    tree
    stow
    tmux

    nodejs

    # Git
    git
    delta

    git-filter-repo
    gitleaks
    lazygit
    #
    # # Editors & LSPs
    neovim
    # lua-language-server
    # stylua
    nixfmt
    # black
    # ruff
    # pyright
    # basedpyright
    # typescript-language-server
    # vscode-langservers-extracted
    # tailwindcss-language-server
    # rust-analyzer
    # gopls
    # clang-tools  # includes clang-format
    #
    # # Languages & runtimes
    # go
    rustup
    uv
    pipx
    # maven
    # meson
    #
    # # Python (pick one, manage versions via uv/pyenv otherwise)
    # python311
    # python39
    #
    # # DevOps & infra
    # docker
    # docker-compose
    # docker-buildx
    # colima
    # kubectl
    # helm
    # k9s
    # kubeconform
    # nebula
    tailscale
    # nmap
    # telnet
    #
    # Cloud & build tools
    pre-commit
    #
    # # Media & docs
    # imagemagick
    # exiftool
    # # typst
    #
    # # Data & science (heavy — comment out if slow)
    # # pytorch
    # # opencv
    # # r
    # # boost
    #
    # # Misc CLI
    # bitwarden-cli
    # exercism
    eza
    fd
    ripgrep
    jq
    bat
    # gnutls
    # openssl
    sesh
    tree-sitter
    # jupyterlab
    #
    # # Fonts / misc
    # # gsl
    opencode

    # Cargo tools
    cargo-generate
    cargo-watch
    rustlings
    tex-fmt
  ];

  # Install pi coding agent via npm global install
  home.activation.installPiCodingAgent = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export NPM_CONFIG_PREFIX="${config.home.homeDirectory}/.pi/npm"
    export PATH="${pkgs.nodejs}/bin:$PATH"
    $DRY_RUN_CMD ${pkgs.nodejs}/bin/npm install -g --ignore-scripts \
      @earendil-works/pi-coding-agent 2>&1
  '';

  home.sessionPath = [ "${config.home.homeDirectory}/.pi/npm/bin" ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
      ];
      styles = {
        "command" = "fg=cyan,bold";
        "builtin" = "fg=cyan,bold";
        "function" = "fg=cyan,bold";
        "alias" = "fg=cyan,bold";
        "unknown-token" = "fg=red,bold";
        "reserved-word" = "fg=yellow";
        "single-quoted-argument" = "fg=green";
        "double-quoted-argument" = "fg=green";
        "dollar-quoted-argument" = "fg=green";
        "path" = "none";
        "path_prefix" = "none";
        "bracket-level-1" = "fg=blue,bold";
        "bracket-level-2" = "fg=magenta,bold";
        "bracket-level-3" = "fg=cyan,bold";
      };
    };

    shellAliases = {
      # eza
      l = "eza -l --icons --git -a";
      lt = "eza --tree --level=2 --long --icons --git";
      ltree = "eza --tree --level=2 --icons --git";
      ls = "eza --icons";
      ll = "eza -la --icons";
      # editors
      v = "nvim";
      vim = "nvim";
      vi = "nvim";
      # kubectl
      k = "kubectl";
      # misc
      cat = "bat";
    };

    sessionVariables = {
      EDITOR = "nvim";
      XDG_CONFIG_HOME = "$HOME/.config";
    };

    initContent = ''
      # Emacs keybindings (disables zsh vim mode)
      bindkey -e

      # Homebrew (Apple Silicon)
      export PATH="/opt/homebrew:$PATH"

      # LM Studio
      export PATH="$PATH:$HOME/.lmstudio/bin"

      # pipx / local bins
      export PATH="$PATH:$HOME/.local/bin"

      # Cargo (until rustup fully managed by Nix)
      export PATH="$PATH:$HOME/.cargo/bin"

      export PATH="$HOME/.pi/npm/bin:$PATH"
    '';
  };
}
