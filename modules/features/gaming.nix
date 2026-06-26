{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.gaming =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        java.enable = true;
        gamemode.enable = true;
        gamescope.enable = true;
        steam = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.steam-stable;
          fontPackages = [ ];
          extest.enable = true;
          protontricks.enable = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          gamescopeSession.enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };

      hardware = {
        xone.enable = true;
        xpadneo.enable = true;
        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };

      environment = {
        sessionVariables.MANGOHUD = "0";
        systemPackages = with pkgs; [
          mangohud
          er-patcher
        ];
      };

      services = {
        udev.packages = with pkgs; [
          game-devices-udev-rules
        ];
      };

      nix.settings = {
        extra-substituters = [
          "https://nix-gaming.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        ];
      };
    };

  perSystem =
    {
      system,
      ...
    }:
    let
      stablePkgs = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.steam-stable = stablePkgs.steam;
    };
}
