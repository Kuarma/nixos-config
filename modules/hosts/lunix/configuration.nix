{ self, inputs, ... }: {

    flake.nixosModules.lunaConfiguration = { config, pkgs, lib, ... }: {

    imports = [
      inputs.disko.nixosModules.disko
      self.nixosModules.diskoConfig

      inputs.home-manager.nixosModules.default 

      self.nixosModules.lunaHardware 
      self.nixosModules.niri
      self.nixosModules.neovim
      self.nixosModules.kitty
      self.nixosModules.librewolf
      self.nixosModules.gaming
      self.nixosModules.git
      self.nixosModules.tmux
      self.nixosModules.greetd
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ]; # default

    boot.loader = { 
      limine = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    networking.networkmanager.enable = true; # default

    services.xserver.videoDrivers = [ "nvidia" ]; # nvidia module

    boot = { # nvidia 
      blacklistedKernelModules = [ "nouveau" ];
      kernelParams = [ "nvidia-drm.modeset=1" "kvm-intel" "quiet" ];
      plymouth.enable = true;
    };

    hardware.nvidia = { # nvidia
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    time.timeZone = "Europe/Zurich"; # stay 

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

    console.keyMap = "sg"; # stay

    security.rtkit.enable = true; # stay

    services.pipewire = { # stay
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users.luna = { # stay
      isNormalUser = true;
      initialPassword = "changeme";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    networking.hostName = "lunix"; # stay

    home-manager = {
      users.luna = self.homeModules.lunaModule;
      useGlobalPkgs = true;
      useUserPackages = true;
      overwriteBackup = true;
      backupFileExtension = "backup";
    };

    environment.systemPackages = with pkgs; [
      wget # default
      unzip
      btop
    ];

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.11";
  };
}
