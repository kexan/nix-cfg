{
  inputs,
  ...
}:

{
  flake.modules.homeManager.zen-browser =
    { lib, config, ... }:
    {
      imports = [
        inputs.zen-browser.homeModules.beta
        inputs.plasma-manager.homeModules.plasma-manager
      ];

      programs.zen-browser = {
        enable = true;
        profiles.kexan = {
          spacesForce = true;
          pinsForce = true;

          settings = {
            "browser.aboutConfig.showWarning" = false;
            "browser.search.region" = "RU";
            "browser.search.suggest.enabled" = true;
            "browser.urlbar.placeholderName" = "Google";
            "browser.urlbar.placeholderName.private" = "Google";
            "browser.translations.automaticallyPopup" = false;
            "intl.locale.requested" = "ru,en-US";
            "intl.regional_prefs.use_os_locales" = true;
            "intl.accept_languages" = "ru-RU, ru, en-US, en";
            "font.cjk_pref_fallback_order" = "ja,zh-cn,zh-hk,zh-tw,ko";
            "font.name.monospace.ja" = "Noto Sans Mono CJK JP";
            "font.name.sans-serif.ja" = "Noto Sans CJK JP";
            "font.name.serif.ja" = "Noto Serif CJK JP";
            "font.name-list.emoji" = "JoyPixels, Noto Color Emoji, Twemoji Mozilla";
            "zen.welcome-screen.seen" = true;
          };

          # === Essentials ===
          pins = {
            "YouTube" = {
              id = "e0000001-0000-0000-0000-000000000001";
              url = "https://www.youtube.com/";
              isEssential = true;
              position = 10;
            };
            "Gmail" = {
              id = "e0000002-0000-0000-0000-000000000002";
              url = "https://mail.google.com/mail/u/0/#inbox";
              isEssential = true;
              position = 20;
            };
          };
        };
      };

      programs.plasma = lib.mkIf (config.programs.plasma.enable or false) {
        shortcuts = {
          "services/zen-beta.desktop"._launch = "Meta+Z";
        };
      };
    };
}
