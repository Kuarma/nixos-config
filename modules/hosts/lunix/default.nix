{ self, inputs, ... }: {

  flake.nixosConfigurations.lunix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.lunaConfiguration
    ];
  };
}
