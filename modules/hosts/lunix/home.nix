{ self, inputs, ... }: {

  flake.homeModules.lunaModule = { pkgs, ... }: {

    imports = [
      self.homeModules.discord
    ];

    home.enableNixpkgsReleaseCheck = false;

    home.stateVersion = "26.05";
  };
}
