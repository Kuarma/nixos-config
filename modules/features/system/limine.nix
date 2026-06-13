{
  ...
}:
{
  flake.nixosModules.limine =
    {
      ...
    }:
    {
      boot = {
        plymouth.enable = true;
        loader = {
          limine = {
            enable = true;
            secureBoot = {
              enable = true;
              autoEnrollKeys.enable = true;
              autoGenerateKeys = true;
            };
          };
          efi.canTouchEfiVariables = true;
        };
      };
    };
}
