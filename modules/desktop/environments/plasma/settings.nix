{
  flake.modules = {
    homeManager.plasma =
      { config, pkgs, ... }:
      {
        programs.plasma = {

          krunner = {
            position = "center";
            historyBehavior = "enableSuggestions";
          };

          configFile = {
            kcminputrc = {
              "Libinput/13364/53288/Keychron Keychron Ultra-Link 8K".NaturalScroll = true;
              "Libinput/13364/53288/Keychron Keychron Ultra-Link 8K".PointerAccelerationProfile = 1;

              "Libinput/10182/480/GXTP7863:00 27C6:01E0 Touchpad".DisableWhileTyping = false;
              "Libinput/10182/480/GXTP7863:00 27C6:01E0 Touchpad".NaturalScroll = true;
              "Libinput/10182/480/GXTP7863:00 27C6:01E0 Touchpad".ScrollFactor = 0.5;
            };

            kdeglobals = {
              General = {
                accentColorFromWallpaper = true;
                fixed = "FiraCode Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
              };
            };

            kscreenlockerrc = {
              Daemon.LockGrace = 300;
              Daemon.Timeout = 200;
            };

            ksmserverrc = {
              General.loginMode = "emptySession";
            };

            kwinrc = {
              Desktops = {
                Id_1 = "590e19e8-9580-4cf9-b56d-e944544c340b";
                Id_2 = "303f2d41-95ed-41ee-ab52-41238411c432";
                Id_3 = "7e838448-4c25-4e2d-ba8c-a00be4ebf179";
                Id_4 = "6ff37b80-223a-426e-a98e-459919b07c0c";
                Id_5 = "e448198e-8437-48dc-9b06-61878b7a8c99";
                Number = 5;
                Rows = 1;
              };
              Windows = {
                DelayFocusInterval = 0;
                FocusPolicy = "FocusFollowsMouse";
                FocusStealingPreventionLevel = 1;
              };
              "org.kde.kdecoration2" = {
                ButtonsOnLeft = "XI";
                ButtonsOnRight = "SHM";
              };
            };

            kxkbrc = {
              Layout = {
                DisplayNames = ",";
                LayoutList = "us,ru";
                Options = "grp:caps_toggle";
                ResetOldOptions = true;
                Use = true;
                VariantList = ",";
              };
            };

            plasma-localerc.Formats.LANG = "ru_RU.UTF-8";
          };
        };
      };
  };
}
