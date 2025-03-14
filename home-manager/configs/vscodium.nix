{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhs;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;
    keybindings = [
      {
        key = "ctrl+'";
        command = "workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "ctrl+`";
        command = "-workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "ctrl+h";
        command = "workbench.action.previousEditor";
      }
      {
        key = "ctrl+pageup";
        command = "-workbench.action.previousEditor";
      }
      {
        key = "ctrl+l";
        command = "workbench.action.nextEditor";
      }
      {
        key = "ctrl+pagedown";
        command = "-workbench.action.nextEditor";
      }
      {
        key = "shift+alt+/";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+/";
        command = "-editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "shift+alt+a";
        command = "editor.action.blockComment";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+shift+a";
        command = "-editor.action.blockComment";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+p";
        command = "-extension.vim_ctrl+p";
        when = "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
      }
      {
        key = "ctrl+shift+;";
        command = "editor.action.revealDefinition";
        when = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor";
      }
      {
        key = "ctrl+alt+i";
        command = "editor.action.formatDocument";
        when = "editorHasDocumentFormattingProvider";
      }
      {
        key = "f12";
        command = "-editor.action.revealDefinition";
        when = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor";
      }
      {
        key = "ctrl+shift+e";
        command = "workbench.explorer.fileView.focus";
      }
    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;

      "editor.fontFamily" = "azeret-mono, monospace";
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "bold";
      "editor.lineNumbers" = "relative";
      "editor.minimap.enabled" = false;
      "editor.renderLineHighlight" = "all";
      "editor.semanticHighlighting.enabled" = true;
      "window.menuBarVisibility" = "toggle";
      "window.titleBarStyle" = "custom";
      "window.customMenuBarAltFocus" = false;

      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "typescript.preferences.importModuleSpecifier" = "relative";
      "javascript.preferences.importModuleSpecifier" = "relative";

      "javascript.inlayHints.parameterNames.enabled" = "all";

      "typescript.inlayHints.parameterNames.enabled" = "all";
      "typescript.inlayHints.variableTypes.enabled" = true;
      "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;

      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
      "explorer.compactFolders" = false;
      "breadcrumbs.enabled" = false;
      "php.validate.enable" = true;

      "nix" = {
        "enableLanguageServer" = true;
        "serverPath" = "nil";
        "serverSettings" = {
          "nil" = {
            "diagnostics" = {
              # "ignored" = ["unused_binding" "unused_with"];
            };
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
      };

      "java.server.launchMode" = "Standard";
      "java.signatureHelp.description.enabled" = true;
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      esbenp.prettier-vscode
      rust-lang.rust-analyzer
      pkief.material-icon-theme
      donjayamanne.githistory
      waderyan.gitblame
      editorconfig.editorconfig
      golang.go
      jnoortheen.nix-ide
      devsense.profiler-php-vscode
    ];
  };
}
