{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.gaming = { pkgs, lib, ... }: {
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
    ];

    nixpkgs.config.allowUnfree = true;

    programs = {
      java.enable = true;
      gamemode.enable = true;
      gamescope = {
        enable = true;
        capSysNice = false; # https://github.com/NixOS/nixpkgs/issues/523200
      };
      steam = {
        enable = true;
        extraPackages = with pkgs; [
          gamemode
        ];
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

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment = {
      sessionVariables.MANGOHUD = "1";
      systemPackages = with pkgs; [
        steam-run
        mangohud
        er-patcher
        inputs.nix-citizen.packages.${pkgs.stdenv.hostPlatform.system}.rsi-launcher
      ];
    };

    boot.kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        lowLatency = {
          enable = true;
          quantum = 64;
          rate = 48000;
        };
      };
      udev.packages = with pkgs; [
        game-devices-udev-rules
      ];
    };

    nix.settings = {
      extra-substituters = [
        "https://nix-gaming.cachix.org"
        "https://nix-citizen.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      ];
    };
  };
}
