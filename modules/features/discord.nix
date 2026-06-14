{
  inputs,
  ...
}:
{
  flake.homeModules.discord =
    {
      ...
    }:
    {
      imports = [
        inputs.nixcord.homeModules.nixcord
      ];

      programs.nixcord = {
        enable = true;
        vesktop.enable = true;
        config = {
          useQuickCss = true;
          frameless = true;
          disableMinSize = true;
        };
      };
    };
}
