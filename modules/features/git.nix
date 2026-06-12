{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.git =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs = {
        git = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.git-pkg;
        };
        lazygit.enable = true;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.git-pkg = inputs.wrapper-modules.wrappers.git.wrap {
        inherit pkgs;
        settings = {
          init.defaultBranch = "main";
          core = {
            autoSetupRemote = true;
            fsmonitor = true;
          };
          user = {
            name = "Kuarma";
            email = "mas.schibli@kuarma.com";
          };
          gpg.format = "ssh";
        };
      };
    };
}
