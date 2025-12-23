{ inputs, ... }:

{
  flake.modules = {
    homeManager.desktop = {
      imports = [ inputs.zen-browser.homeModules.beta ];
      programs.zen-browser = {
        enable = true;
        profiles.kexan = {
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
        };
      };
    };
  };
}
