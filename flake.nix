{
  description = "deeplungs - pneumonia checker";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{flake-parts, ...} :
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem = { pkgs, ... }:
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python3
            stdenv.cc.cc.lib
            ruff
            basedpyright
            uv
          ];
          LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
          shellHook = ''
            unset PYTHONPATH
            uv sync
            . .venv/bin/activate
          '';
        };
      };
    };
}

