{ pkgs, userName, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  system.primaryUser = userName;
  system.stateVersion = 6;

  users.users.${userName}.home = "/Users/${userName}";

  programs.zsh.enable = true;

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
