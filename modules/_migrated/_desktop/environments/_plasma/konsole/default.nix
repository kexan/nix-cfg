{
  flake.modules = {
    homeManager.plasma = {
      programs.konsole = {
        enable = true;
        defaultProfile = "Main";

        customColorSchemes = {
          Gruvbox = ./gruvbox.colorscheme;
        };

        profiles.Main.colorScheme = "Gruvbox";

        extraConfig = {
          MainWindow = {
            MenuBar = "Disabled";
          };
        };
      };

      #FIXME: hacky way to hide toolbar
      xdg.dataFile."kxmlgui5/konsole/konsoleui.rc".text = ''
        <!DOCTYPE gui>
        <gui name="konsole" version="19">
          <ToolBar name="mainToolBar" hidden="true">
            <text>Main Toolbar</text>
          </ToolBar>
        </gui>
      '';
    };
  };
}
