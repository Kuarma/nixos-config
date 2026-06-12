{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.neovim =
    {
      pkgs,
      ...
    }:
    let
      dotnet =
        with pkgs.dotnetCorePackages;
        combinePackages [
          sdk_8_0
          sdk_9_0
          sdk_10_0
          sdk_11_0
        ];
    in
    {
      programs.neovim = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-pkg;
        defaultEditor = true;
        viAlias = true;
      };
      environment = {
        systemPackages = with pkgs; [
          # Nix
          nixfmt
          nixd

          # CSharp
          dotnet-ef
          dotnet

          # Treesitter
          luaPackages.tree-sitter-cli

          # Misc
          fzf
          ripgrep
        ];
        sessionVariables = {
          DOTNET_ROOT = "${dotnet}";
        };
      };
    };

  perSystem =
    {
      pkgs,
      config,
      ...
    }:
    {
      packages.nvim-pkg = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;

        settings.config_directory = ./.;

        runtimePkgs = with pkgs; [
          # System utilities
          ffmpeg-full
          wl-clipboard
          biber
          miktex
          zathura
          xdotool
          pstree

          # LSP servers
          lua-language-server
          vscode-langservers-extracted

          # Formatters
          oxfmt
          stylua
          yamlfmt
          tex-fmt
          bibtex-tidy

          # Markdown
          marksman

          # Spelling
          codespell

          # Easy-Dotnet
          config.packages.easy-dotnet-server
        ];

        specs.init = {
          data = null;
          before = [ "MAIN_INIT" ];
          config = "require('init')";
        };

        specs.plugins = {
          data = with pkgs.vimPlugins; [
            # Treesitter
            nvim-treesitter.withAllGrammars
            nvim-treesitter-textobjects
            nvim-ts-autotag

            # LSP
            nvim-lspconfig

            # Completion & snippets
            blink-cmp
            blink-compat
            colorful-menu-nvim
            lspkind-nvim
            luasnip

            # Latex
            vimtex

            # Core dependencies
            lz-n
            plenary-nvim
            nvim-nio

            # Navigation
            vim-tmux-navigator

            # UI & appearance
            tokyonight-nvim
            nvim-web-devicons
            nui-nvim
            nvim-colorizer-lua
            noice-nvim
            nvim-notify
            which-key-nvim

            # Start screen & statusline
            alpha-nvim
            lualine-nvim

            # Language-specific
            easy-dotnet-nvim
          ];
        };

        specs.lazyPlugins = {
          lazy = true;
          data = with pkgs.vimPlugins; [
            # Debugging (DAP)
            nvim-dap
            nvim-dap-ui
            nvim-dap-view
            nvim-dap-virtual-text

            # File explorer
            oil-nvim
            oil-git-nvim
            oil-lsp-diagnostics-nvim

            # Editing
            nvim-autopairs
            inc-rename-nvim

            # Git
            gitsigns-nvim
            lazygit-nvim

            # Navigation & project management
            harpoon2

            # Notes & task tracking
            todo-comments-nvim

            # Development helpers
            lazydev-nvim
            conform-nvim

            # History
            undotree

            # Diagnostics & quickfix
            trouble-nvim
            nvim-bqf

            # Telescope
            telescope-nvim
            telescope-fzf-native-nvim
            telescope-media-files-nvim
            telescope-ui-select-nvim
          ];
        };
      };
    };
}
