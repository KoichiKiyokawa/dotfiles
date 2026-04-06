{
  description = "Koichi's dotfiles managed by home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      apps = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          homeManagerCli = home-manager.packages.${system}.default;
        in {
          switch = {
            type = "app";
            program = toString (pkgs.writeShellScript "home-manager-switch" ''
              set -eu

              : "''${DOTFILES_ROOT:?DOTFILES_ROOT must point to the dotfiles checkout}"

              nix_escape() {
                printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
              }

              mkdir -p "$DOTFILES_ROOT/zsh"
              touch "$DOTFILES_ROOT/zsh/local.zsh"

              wrapper="$(mktemp -t home-manager-dotfiles)"
              trap 'rm -f "$wrapper"' EXIT

              escaped_home="$(nix_escape "$HOME")"
              escaped_root="$(nix_escape "$DOTFILES_ROOT")"

              cat > "$wrapper" <<EOF
              { ... }:
              {
                _module.args.localConfig = {
                  homeDirectory = "$escaped_home";
                  dotfilesDir = "$escaped_root";
                };

                imports = [ (builtins.toPath "$escaped_root/home.nix") ];
              }
              EOF

              exec ${homeManagerCli}/bin/home-manager switch -f "$wrapper" -I nixpkgs=${pkgs.path} "$@"
            '');
          };
        });
    };
}
