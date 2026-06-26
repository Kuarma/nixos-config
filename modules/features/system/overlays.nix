{
  inputs,
  ...
}:
{
  flake.nixosModules.overlays =
    {
      ...
    }:
    {
      nixpkgs.overlays = [
        (_: prev: {
          cantarell-fonts = inputs.nixpkgs-stable.legacyPackages.${prev.system}.cantarell-fonts;
        })
      ];
    };
}
