{ self, inputs, ... }: {

  flake.nixosModules.nixdowsConfig =
    {
      pkgs,
      ...
    }:
    {

      imports = [
        inputs.nixos-wsl.nixosModules.default

        self.nixosModules.neovim
        self.nixosModules.kitty
        self.nixosModules.git
        self.nixosModules.tmux
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      time.timeZone = "Europe/Zurich";

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

      console.keyMap = "sg";

      wsl.enable = true;
      wsl.defaultUser = "wsl";

      networking.hostName = "nixdows";

      users.users.wsl = {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      environment.systemPackages = with pkgs; [
        wget
        unzip
        btop
      ];

      system.stateVersion = "26.05";
    };
}
