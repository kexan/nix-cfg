{
  flake.modules.homeManager.desktop =
    { lib, ... }:
    let
      radius = 12.0;
      cornerRadius = {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };

      browsers = [
        "zen"
        "zen-beta"
      ];

      screencastBlocked = [
        "org.telegram.desktop"
      ];

      alwaysFloatingApps = [
        "pavucontrol"
        "pavucontrol-qt"
        "com.saivert.pwvucontrol"
        "dialog"
        "popup"
        "task_dialog"
        "file-roller"
        "org.gnome.FileRoller"
        "xdg-desktop-portal-gtk"
        "org.kde.polkit-kde-authentication-agent-1"
      ];

      alwaysFloatingTitles = [
        "Progress"
        "File Operations"
        "Copying"
        "Moving"
        "Properties"
        "Downloads"
        "file progress"
        "Confirm"
        "Authentication Required"
        "Notice"
        "Warning"
        "Error"
      ];

      windowRules = [
        {
          geometry-corner-radius = cornerRadius;
          clip-to-geometry = true;
          draw-border-with-background = false;
        }

        {
          matches = [ { is-floating = true; } ];
          shadow.enable = true;
        }

        {
          matches = [ { is-window-cast-target = true; } ];
          focus-ring = {
            active.color = "#f38ba8";
            inactive.color = "#7d0d2d";
          };
          border.inactive.color = "#7d0d2d";
          shadow.color = "#7d0d2d70";
          tab-indicator = {
            active.color = "#f38ba8";
            inactive.color = "#7d0d2d";
          };
        }

        {
          matches = map (id: { app-id = id; }) screencastBlocked;
          block-out-from = "screencast";
        }

        {
          matches = map (id: { app-id = id; }) browsers;
          scroll-factor = 0.6;
        }

        {
          matches = map (id: { app-id = id; }) browsers;
          open-maximized = true;
        }

        {
          matches = map (id: { app-id = id; }) alwaysFloatingApps;
          open-floating = true;
        }

        {
          matches = map (t: { title = t; }) alwaysFloatingTitles;
          open-floating = true;
        }
      ];
    in
    {
      programs.niri.settings = {
        window-rules = windowRules;

        layer-rules = [
          {
            matches = [ { namespace = "^noctalia-overview*"; } ];
            place-within-backdrop = true;
          }
        ];
      };
    };
}
