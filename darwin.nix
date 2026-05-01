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

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    casks = [
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
