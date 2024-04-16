{pkgs, ...}:{
  xdg = {
    # desktopEntries = {
    #   firefox = {
    #     name = "Firefox";
    #     genericName = "Web Browser";
    #     exec = pkgs.firefox;
    #     mimeType = ["text/html" "text/xml"];
    #   }
    # };

    mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = "nautilus.desktop";
        "application/pdf" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        # Add your custom mimetype entry for file paths here
        # "text/plain" = "gedit.desktop";  # Example for text files
        # "image/jpeg" = "gthumb.desktop";  # Example for JPEG images
      };
      defaultApplications = {
        "inode/directory" = "nautilus.desktop";
      };
    };
  };
}