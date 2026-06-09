{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      useNautilus = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri-pkg;
    };

    services.playerctld.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ 
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-dbus-proxy
      ];
      config.common.default = 
      [
        "gnome" 
        "gtk"
      ];
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.niri-pkg = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; 
      v2-settings = true;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia-pkg)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

	hotkey-overlay = {
          skip-at-startup = _: { };
        };

	layout = {
          gaps = 2;

          center-focused-column = "never";

          preset-column-widths = [
            { proportion = 0.5; }
            { proportion = 1.0; }
          ];

          focus-ring = {
            off = _: { };
          };

          border = {
            off = _: { };
          };
        };

        window-rules = [
          {
            border = {
              on = _: { };
              width = 1;
              active-color = "#f5f5f5";
              inactive-color = "#252525";
              urgent-color = "#ac4142";
            };
          }
        ];

	cursor = {
          xcursor-theme = "Adwaita";
          hide-when-typing = _: { };
          hide-after-inactive-ms = 3000;
        };

	outputs = {
	  "DP-2" = {
            mode = "5120x1440@239.761";
	    scale = 1.0;
	  };
	  variable-refresh-rate = true;
	  focus-at-startup = true;
	};

        gestures = {
          hot-corners = {
            off = _: { };
          };
        };

	prefer-no-csd = _: { };

        input = { 
	  keyboard = {
	    xkb.layout = "ch";
	    numlock = _: { };
	  };
        
	  warp-mouse-to-focus = _: { };

          focus-follows-mouse = _: {
            props = {
              max-scroll-amount = "0%";
            };
          };
	};

	environment = {
          CLUTTER_BACKEND = "wayland";
          GDK_BACKEND = "wayland,x11";
          MOZ_ENABLE_WAYLAND = "1";
          NIXOS_OZONE_WL = "1";
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";

          XDG_SESSION_TYPE = "wayland";
          XDG_CURRENT_DESKTOP = "niri";
          DISPLAY = ":0";
        };

        binds = {
          "Mod+X".spawn = "kitty";
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.noctalia-pkg} ipc call launcher toggle";
          "Mod+B".spawn = "librewolf";
          "Mod+E".spawn = lib.getExe pkgs.nautilus;

	  "Mod+W".close-window = _: { };
          "Mod+T".toggle-window-floating = _: { };
          "Mod+F".fullscreen-window = _: { };

	  "Print".screenshot = _: { };

          "Mod+H".focus-column-left = _: { };
          "Mod+J".focus-window-down = _: { };
          "Mod+K".focus-window-up = _: { };
          "Mod+L".focus-column-right = _: { };

          "Mod+Shift+H".move-column-left = _: { };
          "Mod+Shift+L".move-column-right = _: { };
          "Mod+Shift+K".move-window-up = _: { };
          "Mod+Shift+J".move-window-down = _: { };

	  "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

	  "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: { };
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: { };
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: { };


          "Mod+D".focus-workspace-down = _: { };
          "Mod+U".focus-workspace-up = _: { };

          "Mod+Shift+D".move-column-to-workspace-down = _: { };
          "Mod+Shift+U".move-column-to-workspace-up = _: { };

          "Mod+Control+D".move-workspace-down = _: { };
          "Mod+Control+U".move-workspace-up = _: { };

	  
          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";

          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "XF86AudioMute" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SINK@"
                "toggle"
              ];
            };
          };
          "XF86AudioPlay" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "playerctl"
                "play-pause"
              ];
            };
          };
          "XF86AudioPrev" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "playerctl"
                "previous"
              ];
            };
          };
          "XF86AudioNext" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn = [
                "playerctl"
                "next"
              ];
            };
          };

          "XF86AudioRaiseVolume" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ --limit 1.0";
            };
          };
          "XF86AudioLowerVolume" = _: {
            props = {
              allow-when-locked = true;
            };
            content = {
              spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            };
          };
        };
      };
    };
  };
}
