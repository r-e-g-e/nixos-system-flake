{...}:{
  services.dusnt = {
    enable = true;
    settings = {
      global = {
        font = "JetbrainsMono NF 11";
        word_wrap = "yes";
        markup = "full";
        follow = "mouse";
        offset = "20x24";
      };

      width = "(0, 500)";
      corner_radius = 10;

      timeout = 5;
      show_age_threshold = 60;
      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = "no";
      indicate_hidden = "yes";

      frame_width = 2;
      progress_bar_frame_width = 0;
      progress_bar_corner_radius = 5;

      min_icon_size = 0;
      max_icon_size = 80;
      icon_corner_radius = 5;
      text_icon_padding = 10;

      dmenu = "/usr/bin/rofi -p dunst";
      browser = "/usr/bin/firefox --new-tab";

      mouse_left_click = "do_action";
      mouse_middle_click = "close_all";
      mouse_right_click = "close_current";

      urgency_low = {
        background = "#!!{primary}88";
        foreground = "#!!text";
        frame_color = "#!!accent";
      };
      urgency_normal = {
        background = "#!!{primary}88";
        foreground = "#!!text";
        frame_color = "#!!accent";
      };
      urgency_critical = {
        background = "#!!{primary}88";
        foreground = "#!!text";
        frame_color = "#!!accent";
      };

    };
  };
}