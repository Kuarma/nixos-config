{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.pipewire =
    {
      pkgs,
      ...
    }:
    {
      services.pipewire = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.pipewire-stable;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        lowLatency = {
          enable = true;
          quantum = 64;
          rate = 48000;
        };
      };
      security.rtkit.enable = true;
    };

  perSystem =
    {
      system,
      ...
    }:
    let
      stablePkgs = import inputs.nixpkgs-stable {
        inherit system;
      };
    in
    {
      packages.pipewire-stable = stablePkgs.pipewire;
    };
}
