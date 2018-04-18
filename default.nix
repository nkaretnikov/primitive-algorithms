{ mkDerivation, base, ghc-prim, HUnit, stdenv }:
mkDerivation {
  pname = "primitive-algorithms";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base ghc-prim HUnit ];
  testHaskellDepends = [ base ghc-prim HUnit ];
  license = stdenv.lib.licenses.publicDomain;
}
