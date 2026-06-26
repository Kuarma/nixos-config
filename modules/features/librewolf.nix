{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.librewolf =
    {
      pkgs,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.librewolf-stable;
        policies = {
          ManagedBookmarks = [
            {
              name = "Search";
              children = [
                {
                  name = "NixOS";
                  url = "https://search.nixos.org/";
                }
                {
                  name = "Noogle";
                  url = "https://noogle.dev/";
                }
              ];
            }
            {
              name = "GitHub";
              url = "https://github.com/";
            }
          ];
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          Preferences = {
            "cookiebanners.service.mode.privateBrowsing" = 2;
            "cookiebanners.service.mode" = 2;
            "privacy.donottrackheader.enabled" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.trackingprotection.emailtracking.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.clearOnShutdown_v2.cookiesAndStorage.enabled" = false;
          };
          ExtensionSettings = {
            "duckDuckGo" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
              installation_mode = "force_installed";
            };
            "uBlock" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };

      environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
    };
  perSystem =
    {
      system,
      ...
    }:
    let
      stablePkgs = import inputs.nixpkgs-stable { inherit system; };
    in
    {
      packages.librewolf-stable = stablePkgs.librewolf;
    };
}
