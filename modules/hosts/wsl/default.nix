{ self, inputs, ... }: {

  flake.nixosConfigurations.nixdows = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.nixdowsConfig
    ];
  };
}
