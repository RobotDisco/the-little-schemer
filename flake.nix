{
  description = "A clj-nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    clj-nix = {
      url = "github:jlesquembre/clj-nix";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, flake-utils, clj-nix }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cljpkgs = clj-nix.packages."${system}";
      in

      {
        packages = {
          reasoned-schemer-clj = cljpkgs.mkCljLib {
            projectSrc = ./.;
            name = "robot-disco/reasoned-schemer";
            main-ns = "reasoned-schemer.core";
          };
        };

        devShells.default = pkgs.mkShell {
          packages = [ pkgs.clojure pkgs.clojure-lsp pkgs.racket ];
        };
      });

}
