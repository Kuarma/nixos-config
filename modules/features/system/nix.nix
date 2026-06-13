{
  ...
}:
{
  flake.nixosModules.nix =
    {
      pkgs,
      ...
    }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        unzip

        alejandra
        manix
        nix-inspect
        nixd
        statix
        nixfmt
      ];
    };
}
