{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.git =
    {
      pkgs,
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
      environment.systemPackages = [
        pkgs.git-credential-manager
      ];
    };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.git-pkg = inputs.wrapper-modules.wrappers.git.wrap {
        inherit pkgs;
        settings = {
          credential.helper = "manager";
          credential.credentialStore = "cache";

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
