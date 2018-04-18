{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, ghc-prim, HUnit, stdenv }:
      mkDerivation {
        pname = "primitive-algorithms";
        version = "0.1.0.0";
        src = ./.;
        libraryHaskellDepends = [ base ghc-prim HUnit ];
        testHaskellDepends = [ base ghc-prim HUnit ];
        license = stdenv.lib.licenses.publicDomain;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
