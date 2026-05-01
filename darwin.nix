{ pkgs, userName, ... }:

let
  versions = import ./versions.nix;
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  system.primaryUser = userName;
  system.stateVersion = versions.darwinStateVersion;

  users.users.${userName}.home = "/Users/${userName}";

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    casks = [
      # The nixpkgs package can lag behind Codex's fast release cadence, so use
      # the Homebrew Cask binary managed through nix-darwin.
      "codex"
      "docker-desktop"
      "google-japanese-ime"
    ];
    masApps = {
      Skitch = 425955336;
    };
  };

  environment.systemPackages = with pkgs; [
    aldente
    docker
    ghostty-bin
    google-cloud-sdk
    karabiner-elements
    keycastr
    raycast
    vscode
  ];
}
