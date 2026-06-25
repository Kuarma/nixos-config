{
  ...
}:
{
  #TODO: Refactor greeter
  flake.nixosModules.greetd =
    {
      ...
    }:
    {
      services.greetd = {
        enable = true;
      };

      programs.regreet = {
        enable = true;
      };
    };
}
