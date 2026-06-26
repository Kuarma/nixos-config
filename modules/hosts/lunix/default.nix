{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.lunix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.default
      inputs.nix-gaming.nixosModules.pipewireLowLatency

      self.nixosModules.lunaConfiguration
      self.nixosModules.diskoConfig
      self.nixosModules.lunaHardware
    ];
  };
}
