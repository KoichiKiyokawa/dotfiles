{ config, pkgs, lib, localConfig, ... }:

let
  versions = import ./versions.nix;
  dotfilesDir = localConfig.dotfilesDir;
  dotfilesCheckout = "${localConfig.homeDirectory}/dotfiles";
  managedFiles = {
    ".zshrc" = "zsh/.zshrc";
    ".config/sheldon/plugins.toml" = "zsh/plugins.toml";
    ".config/zsh-abbr/user-abbreviations" = "zsh/abbreviations";
    ".config/starship.toml" = "zsh/starship.toml";
    ".config/lazygit/config.yml" = "lazygit/config.yml";
    ".config/mise/config.toml" = "mise/config.toml";
    ".config/rtk/config.toml" = "rtk/config.toml";
    ".gitconfig" = ".gitconfig";
    "AGENTS.md" = "AGENTS.md";
  } // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
    ".config/karabiner" = "karabiner";
    "Library/Application Support/com.cmuxterm.app/config.ghostty" = "cmux/config.ghostty";
  };
in
{
  home.username = builtins.baseNameOf localConfig.homeDirectory;
  home.homeDirectory = localConfig.homeDirectory;
  home.stateVersion = versions.homeStateVersion;

  programs.home-manager.enable = true;

  home.sessionVariables = {
    DOTFILES_ROOT = dotfilesCheckout;
  };

  home.packages = with pkgs; [
    awscli2
    curl
    delta
    gh
    git
    jq
    neovim
    peco
    rtk
    sheldon
    starship
  ] ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
    lazygit
    mise
    uv
  ];

  home.file = lib.mapAttrs (_target: source: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesCheckout}/${source}";
    force = true;
  }) managedFiles;

  home.activation.setupRtk = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.rtk}/bin/rtk init -g --codex || true
  '';
}
