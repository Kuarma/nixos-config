{ self, inputs, ... }: {

  flake.nixosModules.neovim = { pkgs, lib, ... }: {
    programs.neovim = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-pkg;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.nvim-pkg = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs; 

      runtimePkgs = with pkgs; [
        ffmpeg-full
        wl-clipboard
      ];

      specs.init = {
        data = null;
        before = ["MAIN_INIT"];
        config = "require('init')";
      };

      specs.plugins = {
	data = with pkgs.vimPlugins; [
	];
      };

      specs.lazyPlugins = {
        lazy = true;
	data = with pkgs.vimPlugins; [
	];
      };
    };
  };
}
