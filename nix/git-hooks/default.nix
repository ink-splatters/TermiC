{
  callPackage,
  ...
}@inputs:
let
  check = callPackage ./check.nix inputs;
  mkHookShell =
    let
      mkHookShellInputs = inputs // {
        inherit (check) shellHook;
      };
    in
    callPackage ./mkhookshell.nix mkHookShellInputs;
in
{
  inherit check;

  shells = {
    hooks = mkHookShell { };
    install-hooks = mkHookShell { exit = true; };
  };
}
