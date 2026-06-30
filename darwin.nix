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

  services.tailscale.enable = true;

  environment.etc."codex/managed_config.toml".source = ./codex/managed_config.toml;

  homebrew = {
    enable = true;
    onActivation.extraEnv = {
      HOMEBREW_NO_REQUIRE_TAP_TRUST = "1";
    };
    taps = [
      "vorssaint/tap"
    ];
    casks = [
      # The nixpkgs package can lag behind Codex's fast release cadence, so use
      # the Homebrew Cask binary managed through nix-darwin.
      "codex"
      "docker-desktop"
      "opencode-desktop"
      "google-japanese-ime"
      "obsidian"
      "shottr"
      "vorssaint"
    ];
    masApps = {
      # Pomodoro timer.
      Flow = 1423210932;
    };
  };

  environment.systemPackages = with pkgs; [
    docker
    ffmpeg
    cmux
    google-cloud-sdk
    karabiner-elements
    keycastr
    ollama
    raycast
    zed-editor
  ];
}
