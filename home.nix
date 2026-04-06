{ config, pkgs, lib, localConfig, ... }:

let
  dotfilesDir = localConfig.dotfilesDir;
  managedFiles = {
    ".config/nvim" = "nvim";
    ".zshrc" = "zsh/.zshrc";
    ".config/sheldon/plugins.toml" = "zsh/plugins.toml";
    ".config/starship.toml" = "zsh/starship.toml";
    ".config/lazygit/config.yml" = "lazygit/config.yml";
    ".gitconfig" = ".gitconfig";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    ".config/karabiner" = "karabiner";
    "Library/Application Support/Code/User/settings.json" = "vscode/settings.json";
  };
in
{
  home.username = builtins.baseNameOf localConfig.homeDirectory;
  home.homeDirectory = localConfig.homeDirectory;
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    awscli2
    blueutil
    curl
    delta
    gh
    git
    jq
    lazygit
    mise
    neovim
    peco
    sheldon
    starship
  ];

  home.file = lib.mapAttrs (_target: source: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${source}";
  }) managedFiles;
}
