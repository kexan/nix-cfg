{
  flake.modules.homeManager.zen-browser = {
    programs.zen-browser.profiles.default =
      let
        spaceWorkId = "d2222222-b2a1-4098-8765-43210fedcba9";

        folderWorkTestingId = "f0000002-0000-0000-0000-000000000002";
        folderWorkDocsId = "f0000005-0000-0000-0000-000000000005";
        folderWorkUtilsId = "f0000006-0000-0000-0000-000000000006";
      in
      {
        spaces = {
          "РАБота" = {
            id = spaceWorkId;
            icon = "👷";
            position = 200;
            theme = {
              type = "gradient";
              colors = [
                {
                  red = 52;
                  green = 152;
                  blue = 219;
                  algorithm = "floating";
                  type = "explicit-lightness";
                }
                {
                  red = 41;
                  green = 128;
                  blue = 185;
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
          "Yougile" = {
            id = "p2000001-0000-0000-0000-000000000001";
            url = "https://test-ru.yougile.com/team/e773f3991465/Box-Team-%F0%9F%A6%BE-%F0%9F%93%A6";
            workspace = spaceWorkId;
            position = 200;
            editedTitle = true;
          };
          "Zammad" = {
            id = "p2000002-0000-0000-0000-000000000002";
            url = "https://servicedesk.yougile.com/#ticket/view/my_assigned";
            workspace = spaceWorkId;
            position = 210;
            editedTitle = true;
          };
          "Bitrix" = {
            id = "p2000003-0000-0000-0000-000000000003";
            url = "https://yougile.bitrix24.ru/online/?current_fieldset=SOCSERV";
            workspace = spaceWorkId;
            position = 220;
            editedTitle = true;
          };
          "Gitlab" = {
            id = "p2000004-0000-0000-0000-000000000004";
            url = "https://git.yougile.com/main/yougile";
            workspace = spaceWorkId;
            position = 230;
            editedTitle = true;
          };

          # Folder "Тестирование"
          "Тестирование" = {
            id = folderWorkTestingId;
            workspace = spaceWorkId;
            isGroup = true;
            position = 240;
          };

          "Win Yougile 2.2" = {
            id = "p2000005-0000-0000-0000-000000000005";
            url = "http://yg.yougile.local/";
            workspace = spaceWorkId;
            folderParentId = folderWorkTestingId;
            position = 242;
            editedTitle = true;
          };

          "Ubuntu Yougile 2.5" = {
            id = "p2000006-0000-0000-0000-000000000006";
            url = "https://yg.linuxservice.test/";
            workspace = spaceWorkId;
            folderParentId = folderWorkTestingId;
            position = 244;
            editedTitle = true;
          };

          # Folder "Доки"
          "Доки" = {
            id = folderWorkDocsId;
            workspace = spaceWorkId;
            isGroup = true;
            position = 250;
          };
          "База знаний" = {
            id = "p2000007-0000-0000-0000-000000000007";
            url = "https://help.yougile.com/books/baza-znanii-yougile/page/baza-znanii-yougile";
            workspace = spaceWorkId;
            folderParentId = folderWorkDocsId;
            position = 251;
            editedTitle = true;
          };
          "Руководство админа" = {
            id = "p2000008-0000-0000-0000-000000000008";
            url = "https://docs.yougile.com/docs/versions/";
            workspace = spaceWorkId;
            folderParentId = folderWorkDocsId;
            position = 252;
            editedTitle = true;
          };
          "REST API" = {
            id = "p2000009-0000-0000-0000-000000000009";
            url = "https://ru.yougile.com/api-v2#/";
            workspace = spaceWorkId;
            folderParentId = folderWorkDocsId;
            position = 253;
            editedTitle = true;
          };

          # Folder "Полезности"
          "Work: Полезности" = {
            id = folderWorkUtilsId;
            workspace = spaceWorkId;
            isGroup = true;
            position = 260;
          };
          "Work: Qwen" = {
            id = "p2000011-0000-0000-0000-000000000011";
            url = "https://chat.qwen.ai/";
            workspace = spaceWorkId;
            folderParentId = folderWorkUtilsId;
            position = 262;
            editedTitle = true;
          };
          "Work: ChatGPT" = {
            id = "p2000012-0000-0000-0000-000000000012";
            url = "https://chatgpt.com/";
            workspace = spaceWorkId;
            folderParentId = folderWorkUtilsId;
            position = 263;
            editedTitle = true;
          };
          "Work: Kimi" = {
            id = "p2000013-0000-0000-0000-000000000013";
            url = "https://www.kimi.com/";
            workspace = spaceWorkId;
            folderParentId = folderWorkUtilsId;
            position = 264;
            editedTitle = true;
          };
        };
      };

  };
}
