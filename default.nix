# https://input-output-hk.github.io/haskell.nix/tutorials/getting-started/
let
  sources = import ./nix/sources.nix {};
  haskellNix = import sources.haskellNix {};
  pkgs = import
    haskellNix.sources.nixpkgs-unstable
    haskellNix.nixpkgsArgs;
in pkgs.haskell-nix.project {

  modules = [
    {
      packages.network.components.library.preConfigure = ''
        ${pkgs.autoconf}/bin/autoreconf -i
      '';
    }
    {
      packages.network.components.tests.spec.preConfigure = ''
        ${pkgs.autoconf}/bin/autoreconf -i
      '';
    }
  ];

  src = pkgs.haskell-nix.haskellLib.cleanGit {
    name = "network";
    src = ./.;
  };
  compiler-nix-name = "ghc8107";
}
