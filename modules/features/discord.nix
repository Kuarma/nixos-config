{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.discord = { pkgs, ... }: {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];

    programs.nixcord = {
      enable = true;
      vesktop.enable = true;
      config = {
        plugins = {
          alwaysExpandRoles.enable = true;
          betterGifAltText.enable = true;
          betterGifPicker.enable = true;
          friendsSince.enable = true;
          themeAttributes.enable = true;
          noTypingAnimation.enable = true;
          showHiddenChannels = {
            enable = true;
            showMode = 0;
          };
        };
        useQuickCss = true;
        frameless = true;
        disableMinSize = true;
      };
    };
  };
}
