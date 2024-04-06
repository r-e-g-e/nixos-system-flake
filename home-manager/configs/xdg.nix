{pkgs, ...}:{
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # "text/html" = pkgs.firefox;
  };
    
}