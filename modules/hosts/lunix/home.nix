{
  self,
  ...
}:
{
  flake.homeModules.lunaModule =
    {
      ...
    }:
    {
      imports = [
        self.homeModules.discord
      ];

      home.enableNixpkgsReleaseCheck = false;

      home.stateVersion = "26.05";
    };
}
