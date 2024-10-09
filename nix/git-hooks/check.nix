{
  pkgs,
  git-hooks,
  system,
  src,
  ...
}:
git-hooks.lib.${system}.run {
  inherit src;

  hooks = {
    deadnix.enable = true;
    # markdownlint.enable = true;
    nil.enable = true;
    nixfmt-rfc-style.enable = true;
    statix.enable = true;
    #shellcheck.enable = true;
    shfmt.enable = true;
    yamlfmt.enable = true;
    yamllint.enable = true;
  };

  tools = pkgs;
}
