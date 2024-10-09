{
  mkShell,
  lib,
  shellHook,
  stdenvNoCC,
  system,
  ...
}:

{
  exit ? false,
}:
mkShell.override { stdenv = stdenvNoCC; } {
  inherit system;
  shellHook = ''
    ${shellHook}
    echo Done!
    ${lib.optionalString exit "exit"}
  '';
}
