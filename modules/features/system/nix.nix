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

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc.lib
          zlib
          openssl
          icu
        ];
      };

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
