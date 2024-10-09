{
  inputs = {
    flake-compat.url = "github:edolstra/flake-compat";
    flake-utils.inputs.systems.follows = "systems";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  nixConfig = {
    extra-substituters = [
      "https://cachix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    ];
  };

  outputs =
    {
      nixpkgs,
      git-hooks,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) callPackage nixfmt-rfc-style;

        git-hooks-outputs =
          let
            src = ./.;
          in
          callPackage ./nix/git-hooks/default.nix { inherit git-hooks src system; };
        defaultShell = callPackage ./nix/shells.nix { };
      in
      {
        checks = {
          inherit (git-hooks-outputs) check;
        };

        formatter = nixfmt-rfc-style;

        devShells = {
          inherit (defaultShell) default tcc;
          inherit (git-hooks-outputs.shells) hooks install-hooks;
        };
      }
    );
}
