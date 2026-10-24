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

  security.pki.caCertificateBlacklist = [
    "Comodo AAA Services root"
    "emSign ECC Root CA - G3"
  ];

  system.activationScripts.postActivation.text = ''
    ${pkgs.python3}/bin/python3 ${./security/remove-compromised-ca.py} --apply
  '';

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
    brews = [
      # Nixpkgs pnpm cannot run `pnpm setup` from the user profile path.
      "pnpm"
      # Homebrew ships the eMudhra fixes before the pinned nixpkgs packages.
      "uv"
      "mise"
      {
        name = "lazygit";
        args = [ "build-from-source" ];
      }
    ];
    casks = [
      # The nixpkgs package can lag behind Codex's fast release cadence, so use
      # the Homebrew Cask binary managed through nix-darwin.
      "codex"
      "docker-desktop"
      "google-japanese-ime"
      "obsidian"
      "shottr"
      "vorssaint"
      "t3-code"
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
    raycast
    zed-editor
  ];
}
