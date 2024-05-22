{ mkDerivation, aeson, barbies, barbies-th, base, containers
, generic-lens, lib, scientific, some, text
}:
mkDerivation {
  pname = "botocore";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    aeson barbies barbies-th base containers generic-lens scientific
    some text
  ];
  homepage = "https://github.com/brendanhay/amazonka";
  description = "Representation of botocore types";
  license = lib.licenses.bsd3;
}
