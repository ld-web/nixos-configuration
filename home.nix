{ pkgs, ... }: {
  # GNOME Extensions
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        system-monitor.extensionUuid
        alttab-scroll-workaround.extensionUuid
        appindicator.extensionUuid
        just-perfection.extensionUuid
        launch-new-instance.extensionUuid
        lock-keys.extensionUuid
        notification-timeout.extensionUuid
        panel-world-clock-lite.extensionUuid
        color-picker.extensionUuid
      ];
    };
    settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Launch Console";
      command = "kgx";
      binding = "<Super>t";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      ZH = "LANG='zh_TW.UTF-8'";
      sail = "./vendor/bin/sail";
    };
    history = {
      size = 10000;
      path = "/home/lucas/zsh/history";
    };    
    oh-my-zsh = {
      enable = true;
      plugins = [ "bun" "composer" "copyfile" "copybuffer" "git" "history" "jsontools" "symfony6" "dirhistory" ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
      set nu
      syn on
      colo desert
    '';
  };

  home.stateVersion = "24.05";
}

