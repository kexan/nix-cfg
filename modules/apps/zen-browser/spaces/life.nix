{
  flake.modules.homeManager.zen-browser = {
    programs.zen-browser.profiles.default =
      let
        spaceLifeId = "d1111111-e1f6-4a1b-8c9d-0e1f2a3b4c5d";

        folderLifeUtilsId = "f0000001-0000-0000-0000-000000000001";
      in
      {
        spaces = {
          "Жыбзнь" = {
            id = spaceLifeId;
            icon = "🤓";
            position = 100;
            theme = {
              type = "gradient";
              colors = [
                {
                  red = 46;
                  green = 204;
                  blue = 113;
                  algorithm = "floating";
                  type = "explicit-lightness";
                }
                {
                  red = 39;
                  green = 174;
                  blue = 96;
                  algorithm = "floating";
                  type = "explicit-lightness";
                }
              ];
              opacity = 0.3;
              texture = 0.5;
            };
          };
        };

        pins = {
          "jpdb.io" = {
            id = "p1000001-0000-0000-0000-000000000001";
            url = "https://jpdb.io/";
            workspace = spaceLifeId;
            position = 100;
            editedTitle = true;
          };
          "Texthooker" = {
            id = "p1000001-0000-0000-0000-000000000002";
            url = "https://renji-xd.github.io/texthooker-ui/";
            workspace = spaceLifeId;
            position = 101;
            editedTitle = true;
          };
          "NixOS Search" = {
            id = "p1000002-0000-0000-0000-000000000002";
            url = "https://search.nixos.org/packages?channel=unstable&";
            workspace = spaceLifeId;
            position = 110;
            editedTitle = true;
          };
          "Home Manager Search" = {
            id = "p1000003-0000-0000-0000-000000000003";
            url = "https://home-manager-options.extranix.com/?query=&release=master";
            workspace = spaceLifeId;
            position = 120;
            editedTitle = true;
          };

          # Folder "Полезности"
          "Полезности" = {
            id = folderLifeUtilsId;
            workspace = spaceLifeId;
            isGroup = true;
            position = 130;
          };
          "Qwen" = {
            id = "p1000005-0000-0000-0000-000000000005";
            url = "https://chat.qwen.ai/";
            workspace = spaceLifeId;
            folderParentId = folderLifeUtilsId;
            position = 132;
            editedTitle = true;
          };
          "ChatGPT" = {
            id = "p1000006-0000-0000-0000-000000000006";
            url = "https://chatgpt.com/";
            workspace = spaceLifeId;
            folderParentId = folderLifeUtilsId;
            position = 133;
            editedTitle = true;
          };
          "Kimi" = {
            id = "p1000007-0000-0000-0000-000000000007";
            url = "https://www.kimi.com/";
            workspace = spaceLifeId;
            folderParentId = folderLifeUtilsId;
            position = 134;
            editedTitle = true;
          };
        };
      };

  };
}
