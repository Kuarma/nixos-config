{
  ...
}:
{
  flake.nixosModules.supplementary =
    {
      pkgs,
      ...
    }:
    {
      virtualisation.docker = {
        enable = true;
        package = pkgs.docker;
      };

      environment.systemPackages = with pkgs; [
        gimp2
      ];
    };
}
