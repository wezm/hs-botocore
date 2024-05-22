{
  inputs = {
    bellroy-nix-foss.url = "github:bellroy/bellroy-nix-foss";
  };

  outputs = inputs:
    inputs.bellroy-nix-foss.lib.haskellProject {
      cabalPackages = [
        {
          name = "botocore";
          path = ./botocore.nix;
        }
      ];
      supportedCompilers = [ "ghc8107" "ghc92" "ghc94" ];
      defaultCompiler = "ghc94";
      haskellPackagesOverride = { compilerName, haskellLib, final, prev }: {
        barbies-th = haskellLib.unmarkBroken prev.barbies-th;
      };
    };
}
