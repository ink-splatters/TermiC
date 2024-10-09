{
  bashInteractive,
  gccStdenv,
  mkShell,
  tinycc,
  stdenv,
  ...
}:
let

  mkSh =
    let
      _stdenv = stdenv;
    in
    {
      extras ? [ ],
      stdenv ? _stdenv,
    }:
    mkShell.override { inherit stdenv; } { packages = [ bashInteractive ] ++ extras; };
in
{

  default = mkSh { stdenv = gccStdenv; };
  tcc = mkSh { extras = [ tinycc ]; };
}
