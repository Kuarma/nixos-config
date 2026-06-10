{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.neovim = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-pkg;
      defaultEditor = true;
      viAlias = true;
    };

    environment = {
      systemPackages = with pkgs; [
        dotnet-ef
        (
          with pkgs.dotnetCorePackages;
          combinePackages [
            sdk_8_0
            sdk_9_0
            sdk_10_0
            sdk_11_0
          ]
        )
      ];

      sessionVariables = with pkgs; {
        DOTNET_ROOT = "${dotnet-sdk}/share/dotnet/";
      };
    };
  };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.nvim-pkg = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;

        settings.config_directory = ./.;

        runtimePkgs = with pkgs; [
          ffmpeg-full
          wl-clipboard
          ripgrep

          lua-language-server
          nixd

          nixfmt
          oxfmt
          stylua
          marksman

          self.packages.${pkgs.stdenv.hostPlatform.system}.easy-dotnet-server
        ];

        specs.init = {
          data = null;
          before = [ "MAIN_INIT" ];
          config = "require('init')";
        };

        specs.plugins = {
          data = with pkgs.vimPlugins; [
            nvim-treesitter-textobjects
            nvim-treesitter.withAllGrammars
            nvim-ts-autotag

            nvim-lspconfig

            lspkind-nvim
            colorful-menu-nvim
            blink-cmp
            blink-compat
            luasnip
            lazydev-nvim

            oil-nvim
            oil-lsp-diagnostics-nvim
            oil-git-nvim

            lz-n
            vim-tmux-navigator
            plenary-nvim
            nvim-nio

            tokyonight-nvim
            nvim-web-devicons
            lualine-nvim
            snacks-nvim
            nui-nvim
            nvim-colorizer-lua
            noice-nvim
            nvim-notify
            which-key-nvim

            nvim-autopairs
            gitsigns-nvim

            inc-rename-nvim
          ];
        };

        specs.lazyPlugins = {
          lazy = true;
          data = with pkgs.vimPlugins; [
            nvim-dap-virtual-text
            nvim-dap-view
            nvim-dap

            lazygit-nvim
            undotree

            harpoon2

            conform-nvim

            trouble-nvim

            easy-dotnet-nvim

            telescope-nvim
            telescope-fzf-native-nvim
            telescope-media-files-nvim
            telescope-ui-select-nvim
          ];
        };
      };
    };
}
