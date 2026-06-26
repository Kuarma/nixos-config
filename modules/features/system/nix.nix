{
  self,
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

      imports = [
        self.nixosModules.overlays
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

      virtualisation.docker = {
        enable = true;
        package = pkgs.docker;
      };

      environment.systemPackages = with pkgs; [
        unzip

        # Formatters
        stylua
        alejandra
        manix
        nix-inspect
        nixd
        statix
        nixfmt
        dockerfmt
        yamlfmt
        csharpier
      ];
    };
}
