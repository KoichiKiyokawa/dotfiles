{
  description = "Koichi's dotfiles managed by home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      userName = "koichi";
      homeDirectoryFor = system:
        if nixpkgs.lib.hasSuffix "darwin" system
        then "/Users/${userName}"
        else "/home/${userName}";

      pkgsFor = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      homeConfigurationFor = system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor system;
          extraSpecialArgs = {
            localConfig = {
              homeDirectory = homeDirectoryFor system;
              dotfilesDir = self;
            };
          };
          modules = [ ./home.nix ];
        };
    in {
      darwinConfigurations = builtins.listToAttrs (map (system: {
        name = "${userName}-${system}";
        value = nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit userName; };
          modules = [
            ./darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                localConfig = {
                  homeDirectory = homeDirectoryFor system;
                  dotfilesDir = self;
                };
              };
              home-manager.users.${userName} = import ./home.nix;
            }
          ];
        };
      }) [
        "aarch64-darwin"
        "x86_64-darwin"
      ]);

      homeConfigurations = builtins.listToAttrs (map (system: {
        name = "${userName}-${system}";
        value = homeConfigurationFor system;
      }) systems);

      apps = forAllSystems (system:
        let
          pkgs = pkgsFor system;
          switchApp = pkgs.writeShellApplication {
            name = "dotfiles-switch";
            runtimeInputs = [
              home-manager.packages.${system}.default
              pkgs.coreutils
            ] ++ nixpkgs.lib.optionals (nixpkgs.lib.hasSuffix "darwin" system) [
              nix-darwin.packages.${system}.darwin-rebuild
            ];
            text = ''
              mkdir -p "$HOME/dotfiles/zsh"
              touch "$HOME/dotfiles/zsh/local.zsh"

              export NIX_CONFIG="experimental-features = nix-command flakes''${NIX_CONFIG:+
              }''${NIX_CONFIG-}"

              if [[ "${system}" == *-darwin ]]; then
                if [[ "$(id -u)" -eq 0 ]]; then
                  exec darwin-rebuild switch --flake "${self}#${userName}-${system}" "$@"
                fi

                exec sudo darwin-rebuild switch --flake "${self}#${userName}-${system}" "$@"
              fi

              exec home-manager switch --flake "${self}#${userName}-${system}" "$@"
            '';
          };
        in {
          switch = {
            type = "app";
            meta.description = "Apply Koichi's Home Manager configuration";
            program = "${switchApp}/bin/dotfiles-switch";
          };
        });
    };
}
