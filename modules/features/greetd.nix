{
  ...
}:
{
  flake.nixosModules.greetd =
    {
      pkgs,
      ...
    }:
    {
      services.greetd = {
        enable = true;
      };

      programs.regreet = {
        enable = true;
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
      };
    };
}
