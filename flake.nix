{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = rec {
          default = nsearch;
          nsearch = pkgs.callPackage ./default.nix { };
          nsearch-adv = throw "nsearch-adv is deprecated; nix-search-tv is now in nixpkgs. Use pkgs.nix-search-tv directly (e.g. in home-manager: home.packages = [ pkgs.nix-search-tv ];)";
          nrun = pkgs.writeShellApplication {
            name = "nrun";
            runtimeInputs = with pkgs; [ jq fzf ];
            text = pkgs.lib.readFile ./src/nrun;

            meta = with pkgs.lib; {
              description = "Run Nix commands";
              license = licenses.gpl3;
              platforms = platforms.linux ++ platforms.darwin;
              maintainers = with maintainers; [ niksingh710 ];
              mainProgram = "nrun";
            };
          };
          nshell = pkgs.writeShellApplication {
            name = "nshell";
            runtimeInputs = with pkgs; [ jq fzf ];
            text = pkgs.lib.readFile ./src/nshell;

            meta = with pkgs.lib; {
              description = "Initialize a shell with Nix environment";
              license = licenses.gpl3;
              platforms = platforms.linux ++ platforms.darwin;
              maintainers = with maintainers; [ niksingh710 ];
              mainProgram = "nshell";
            };
          };

        };
      };
    };
}
