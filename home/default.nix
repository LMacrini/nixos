{ lib, powerIcon, ... }:
{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lioma";
  home.homeDirectory = "/home/lioma";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  home.file = {
    ".config" = {
      source = ./Home/.config;
      recursive = true;
    };
    "Templates" = {
      source = ./Home/Templates;
      recursive = true;
    };
  };

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/lioma/.config/background";
      picture-uri-dark = "file:///home/lioma/.config/background";
    };

    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3-dark";
      color-scheme = "prefer-dark";
      clock-format = "24h";
      accent-color = "blue";
      monospace-font-name = "FiraCode Nerd Font Mono 10";
      show-battery-percentage = powerIcon;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.gvariant.mkTuple [
          "xkb"
          "us+mac"
        ])
        (lib.gvariant.mkTuple [
          "xkb"
          "gr"
        ])
      ];
      show-all-sources = true;
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "nbsp:zwnj2nb3zwj4"
      ];
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "caffeine@patapon.info"
        "blur-my-shell@aunetx"
        "gnome-ui-tune@itstime.tech"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "just-perfection-desktop@just-perfection"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
      ];
      favorite-apps = [
        "equibop.desktop"
        "com.mitchellh.ghostty.desktop"
        "floorp.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      allow-extension-installation = true;
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [
        "<Ctrl><Shift><Alt>S"
        "Print"
      ];
      toggle-application = [ "<Alt>space" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screenreader = [];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      background-opacity = 0.8;
      custom-background-color = false;
      dash-max-icon-size = 48;
      dock-fixed = false;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      intellihide = false;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      running-indicator-style = "BINARY";
      transparency-mode = "DEFAULT";
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      static-blur = false;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = false;
      events-button = false;
      panel-notification-icon = true;
      power-icon = powerIcon;
      quick-settings = true;
      window-demands-attention-focus = true;
      window-menu-take-screenshot-button = true;
      window-picker-icon = true;
      workspace-switcher-should-show = true;
      world-clock = false;
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-size = 20;
      legacy-tray-enabled = false;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ "<Shift><Control><Alt>1" ];
      switch-to-workspace-left = [ "<Ctrl><Super>Left" ];
      switch-to-workspace-right = [ "<Ctrl><Super>Right" ];
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };

    "wildmouse/urn" = {
      global-hotkeys = false;
      theme = "live-split";
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      [[ $- != *i* ]] && return

      export NO_POINTER_VIEWPORT=1
      export DO_NOT_TRACK=1

      # alias ls='ls --color=auto'
      alias grep='grep --color=auto'
      PS1='[\u@\h \W]\$ '

      eval "$(zoxide init bash)"

      alias cls="clear"
      alias cd="z"
      alias ls="lsd"
      alias la="ls -a"
      alias ll="ls -l"
      alias lla="ls -la"
      alias pyvenv="source ./venv/bin/activate"

      upd-nix-conf() {
        local host=''${1:-default}
        local rebuild_type=''${2:-switch}
        sudo nixos-rebuild $rebuild_type --flake "/etc/nixos#$host"
      }
      upd-nix-flake() {
        local dir=''${pwd} 
        cd /etc/nixos
        sudo nix flake update
        cd ''$dir
      }

      # eval "$(oh-my-posh init bash --config /home/lioma/.config/oh-my-posh/catppuccin_macchiato.omp.json)"
      eval -- "$(/run/current-system/sw/bin/starship init bash --print-full-init)"
      source "$(blesh-share)/ble.sh"

      fortune | cowsay -rC | lolcat
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
