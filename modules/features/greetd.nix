{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.greetd = { pkgs, lib, ... }: {
    services.greetd = {
      enable = true;
    };

    programs.regreet = {
      enable = true;
    };
  };
}
