{
  description = "Reproducer for Bazel 7 PATH issues with Nix(OS)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        bazel_with_action_path_patch = pkgs.callPackage ./packages/bazel_with_action_path_patch.nix {
          inherit (pkgs) bazel_7; inherit nixpkgs;
        };
      in
      {
        packages = rec {
          bazel_7 = pkgs.bazel_7;
          bazel_with_action_path_patch = bazel_with_action_path_patch;
          default = bazel_7;
        };

        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ pkgs.bazel_7 ];
          };
          with_action_path_patch = pkgs.mkShell {
            buildInputs = [ bazel_with_action_path_patch ];
          };
        };
      }
    );
}
