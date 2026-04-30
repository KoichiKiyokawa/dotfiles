{ config, pkgs, lib, localConfig, ... }:

let
  dotfilesDir = localConfig.dotfilesDir;
  dotfilesCheckout = "${localConfig.homeDirectory}/dotfiles";
  managedFiles = {
    ".config/nvim" = "nvim";
    ".zshrc" = "zsh/.zshrc";
    ".config/sheldon/plugins.toml" = "zsh/plugins.toml";
    ".config/starship.toml" = "zsh/starship.toml";
    ".config/lazygit/config.yml" = "lazygit/config.yml";
    ".gitconfig" = ".gitconfig";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    ".config/karabiner" = "karabiner";
    "Library/Application Support/com.mitchellh.ghostty/config.ghostty" = "ghostty/config.ghostty";
    "Library/Application Support/Code/User/settings.json" = "vscode/settings.json";
  };
in
{
  home.username = builtins.baseNameOf localConfig.homeDirectory;
  home.homeDirectory = localConfig.homeDirectory;
  home.stateVersion = "25.05";

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
    lazygit
    mise
    neovim
    peco
    pnpm
    sheldon
    starship
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
  ];

  home.file = lib.mapAttrs (_target: source: {
    source = "${dotfilesDir}/${source}";
  }) managedFiles;
}
