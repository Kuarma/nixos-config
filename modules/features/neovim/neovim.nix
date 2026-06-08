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

      settings.config_directory = ./.;

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
	  lz-n
          plenary-nvim
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
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
