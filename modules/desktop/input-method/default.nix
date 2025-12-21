{ inputs, ... }:
{
  flake.modules = {
    nixos.inputMethod = { pkgs, ... }: {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          waylandFrontend = true;
          plasma6Support = true;
          addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
          ];
        };
      };
    };

    homeManager.inputMethod = { pkgs, ... }: {
      i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
        ];
      };

      # Декларативная конфигурация методов ввода
      i18n.inputMethod.fcitx5.settings = {
        # Глобальные настройки
        globalOptions = {
          "Hotkey/TriggerKeys" = {
            "0" = "Control+space";
          };
          "Hotkey/EnumerateForwardKeys" = {
            "0" = "Alt+Shift_L";
          };
        };

        # Группы методов ввода
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
          };
          "Groups/0/Items/1" = {
            Name = "mozc";
          };
          "Groups/0/Items/2" = {
            Name = "keyboard-ru";
          };
          GroupOrder = {
            "0" = "Default";
          };
        };

        # Настройки аддонов
        addons = {
          classicui.globalSection = {
            # Горизонтальная панель кандидатов
            Vertical = "False";
          };
        };
      };
    };
  };
}
