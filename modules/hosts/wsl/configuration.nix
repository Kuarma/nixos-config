{ self, inputs, ... }: {

    flake.nixosModules.nixdowsConfig = { config, pkgs, lib, ... }: {

    imports = [
      inputs.nixos-wsl.nixosModules.default
      inputs.home-manager.nixosModules.default 

      self.nixosModules.neovim
      self.nixosModules.kitty
      self.nixosModules.git
      self.nixosModules.tmux
    ];

    networking.hostName = "nixdows"; 

    nix.settings.experimental-features = [ "nix-command" "flakes" ]; # default

    networking.networkmanager.enable = true; 

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

    users.users.wsl = { 
      isNormalUser = true;
      initialPassword = "changeme";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    home-manager = {
      users.wsl = self.homeModules.wslModule;
      useGlobalPkgs = true;
      useUserPackages = true;
      overwriteBackup = true;
      backupFileExtension = "backup";
    };

    environment.systemPackages = with pkgs; [
      wget 
      unzip
      btop
    ];

    system.stateVersion = "26.05"; 
  };
}
