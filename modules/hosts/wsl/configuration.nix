{
  self,
  ...
}:
{

  flake.nixosModules.nixdowsConfig =
    {
      ...
    }:
    {
      imports = [
        # System
        self.nixosModules.nix

        self.nixosModules.neovim
        self.nixosModules.fastfetch
        self.nixosModules.git
        self.nixosModules.tmux
        self.nixosModules.btop
        self.nixosModules.supplementary
      ];

      networking.hostName = "nixdows";

      time.timeZone = "Europe/Zurich";

      services.xserver.xkb.layout = "ch";

      console.keyMap = "sg";

      i18n = {
        defaultLocale = "en_US.UTF-8";

        extraLocaleSettings = {
          LC_ADDRESS = "de_CH.UTF-8";
          LC_IDENTIFICATION = "de_CH.UTF-8";
          LC_MEASUREMENT = "de_CH.UTF-8";
          LC_MONETARY = "de_CH.UTF-8";
          LC_NAME = "de_CH.UTF-8";
          LC_NUMERIC = "de_CH.UTF-8";
          LC_PAPER = "de_CH.UTF-8";
          LC_TELEPHONE = "de_CH.UTF-8";
          LC_TIME = "de_CH.UTF-8";
        };
      };

      wsl = {
        enable = true;
        defaultUser = "wsl";
        useWindowsDriver = true;
      };

      users.users.wsl = {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      system.stateVersion = "26.05";
    };
}
