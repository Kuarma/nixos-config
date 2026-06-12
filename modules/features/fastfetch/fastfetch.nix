{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.fastfetch =
    {
      pkgs,
      ...
    }:
    {
      programs.bash.interactiveShellInit = ''
        fastfetch
      '';
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.fastfetch-pkg
      ];
    };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.fastfetch-pkg = inputs.wrapper-modules.wrappers.fastfetch.wrap {
        inherit pkgs;
        settings = (builtins.fromJSON (builtins.readFile ./fastfetch-settings.json));
      };
    };
}
