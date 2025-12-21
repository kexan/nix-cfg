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
          # Ctrl+Alt+Space для включения/выключения Mozc
          "Hotkey/TriggerKeys" = {
            "0" = "Control+Alt+space";
          };
          # Отключаем стандартное переключение между всеми методами
          "Hotkey/EnumerateForwardKeys" = { };
          "Hotkey/EnumerateBackwardKeys" = { };
          # Деактивировать метод ввода той же клавишей
          "Hotkey/DeactivateKeys" = {
            "0" = "Control+Alt+space";
          };
        };

        # Группы методов ввода
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            # По умолчанию используем клавиатурные раскладки (без IME)
            DefaultIM = "keyboard-us";
          };
          # Keyboard layouts для переключения через Caps Lock (настроено в KDE)
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
          };
          "Groups/0/Items/1" = {
            Name = "keyboard-ru";
          };
          # Mozc активируется отдельно через Ctrl+Alt+Space
          "Groups/0/Items/2" = {
            Name = "mozc";
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
