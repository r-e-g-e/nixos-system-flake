{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    systemd.target = "hyprland-session.target";
    settings = {
      mainBar = {
        height = 20; # Waybar height (to be removed for auto height)
        "margin-top" = 3;
        "margin-left" = 10;
        "margin-bottom" = 0;
        "margin-right" = 10;
        spacing = 5; # Gaps between modules (4px)
        "modules-left" = [
          "cpu"
          "memory"
          "tray"
        ];
        "modules-center" = [
          "wlr/workspaces"
        ];
        "modules-right" = [
          "pulseaudio"
          "battery"
          "backlight"
          "network"
          "clock"
        ];
        "wlr/workspaces" = {
          format = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            urgent = "";
            active = "";
            default = "";
          };
        };
        "hyprland/window" = {
          format = "{}";
        };
        tray = {
          "icon-size" = 15;
          "show-passive-items" = true;
          spacing = 10;
        };
        clock = {
          format = "<span color='#bf616a'> </span>{:%I:%M %p}";
          "format-alt" = "<span color='#bf616a'> </span>{:%a %b %d}";
          "tooltip-format" = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
        };
        cpu = {
          interval = 1;
          format = " {usage}%";
          "max-length" = 100;
          "on-click" = "";
        };
        memory = {
          interval = 5;
          format = " {used:0.1f}G";
          "format-alt" = " {}%";
          "max-length" = 10;
        };
        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        network = {
          "format-wifi" = "󰖩 {signalStrength}%";
          "format-ethernet" = "󰈀 wired";
          "format-disconnected" = "󰖪 ";
          "tooltip-format-wifi" = "essid:{essid} \nip:{ipaddr}";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          "format-bluetooth" = "󰥰 {volume}%";
          "format-bluetooth-muted" = "󰝟 󰥰";
          "format-muted" = "󰝟";
          "format-icons" = {
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };
        bluetooth = {
          format = " {status}";
        };
        battery = {
          interval = 5;
          states = {
            warning = 30;
            critical = 15;
          };
          "max-length" = 20;
          format = "{icon} {capacity}%";
          "format-warning" = "{icon} {capacity}%";
          "format-critical" = "{icon} {capacity}%";
          "format-charging" = "<span font-family='Font Awesome 6 Free'></span> {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-full" = "  {capacity}%";
          "format-icons" = [
            " "
            " "
            " "
            " "
            " "
          ];
        };
      };
    };
    style = ''
          * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 11px;
        font-weight: 900;
        margin: 0;
        padding: 0;
      }

      window#waybar {
        /* background-color: rgba(26, 27, 38, 0.5); */
        background-color: transparent;
        color: #ffffff;
        transition-property: background-color;
        transition-duration: 0.5s;
        /* border-top: 8px transparent; */
        border-radius: 0px;
        transition-duration: 0.5s;
        margin: 0px 0px;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        padding: 0 0px;
        color: #7984a4;
        background-color: transparent;
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each workspace name */
        border: none;
        border-radius: 0;
      }

      #workspaces button.focused {
        background-color: transparent;
      }
      #workspace button.hover {
        background-color: transparent;
      }
      #workspaces button.active {
        color: #fff;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #window {
        /* border-radius: 20px; */
        /* padding-left: 10px; */
        /* padding-right: 10px; */
        color: #64727d;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd,
      #bluetooth,
      #custom-hyprPicker,
      #custom-power-menu,
      #custom-spotify,
      #custom-weather,
      #custom-weather.severe,
      #custom-weather.sunnyDay,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.default {
        padding: 0px 15px;
        color: #e5e5e5;
        /* color: #bf616a; */
        border-radius: 20px;
        background-color: #1e1e1e;
      }

      #window,
      #workspaces {
        border-radius: 20px;
        padding: 0px 10px;
        background-color: #1e1e1e;
      }

      #cpu {
        color: #fb958b;
        background-color: #1e1e1e;
      }

      #memory {
        color: #ebcb8b;
        background-color: #1e1e1e;
      }

      #custom-power-menu {
        border-radius: 9.5px;
        background-color: #1b242b;
        border-radius: 7.5px;
        padding: 0 0px;
      }

      #custom-launcher {
        background-color: #1b242b;
        color: #6a92d7;
        border-radius: 7.5px;
        padding: 0 0px;
      }

      #custom-weather.severe {
        color: #eb937d;
      }

      #custom-weather.sunnyDay {
        color: #c2ca76;
      }

      #custom-weather.clearNight {
        color: #cad3f5;
      }

      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight {
        color: #c2ddda;
      }

      #custom-weather.rainyDay,
      #custom-weather.rainyNight {
        color: #5aaca5;
      }

      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight {
        color: #d6e7e5;
      }

      #custom-weather.default {
        color: #dbd9d8;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #pulseaudio {
        color: #7d9bba;
      }

      #backlight {
        /* color: #EBCB8B; */
        color: #8fbcbb;
      }

      #clock {
        color: #c8d2e0;
        /* background-color: #14141e; */
      }

      #battery {
        color: #c0caf5;
        /* background-color: #90b1b1; */
      }

      #battery.charging,
      #battery.full,
      #battery.plugged {
        color: #26a65b;
        /* background-color: #26a65b; */
      }

      @keyframes blink {
        to {
          background-color: rgba(30, 34, 42, 0.5);
          color: #abb2bf;
        }
      }

      #battery.critical:not(.charging) {
        color: #f53c3c;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #disk {
        background-color: #964b00;
      }

      #bluetooth {
        color: #707d9d;
      }

      #bluetooth.disconnected {
        color: #f53c3c;
      }

      #network {
        color: #b48ead;
      }

      #network.disconnected {
        color: #f53c3c;
      }

      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }

      #custom-media.custom-spotify {
        background-color: #66cc99;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }

      #temperature {
        background-color: #f0932b;
      }

      #temperature.critical {
        background-color: #eb4d4b;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      #idle_inhibitor {
        background-color: #2d3436;
      }

      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
      }

      #language {
        background: #00b093;
        color: #740864;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state > label {
        padding: 0 0px;
      }

      #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
      }
    '';
  };
}
