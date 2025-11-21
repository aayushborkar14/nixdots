{ lib, pkgs, ... }:
let
  username = "aayush";
  secrets = builtins.fromJSON (builtins.readFile ./secrets.json);
in
{
  home = {
    packages = with pkgs; [
      hello
      home-manager
      gnumake

      # utilities
      bat
      eza
      fd
      lazygit
      ripgrep

      zip
      unzip

      #languages
      nodejs_24
      rustup

      # rust stuff
      cargo-cache
      cargo-expand

      # debuggers
      gdb

      # lsps
      lua-language-server
      clang-tools
      pyright
      ruff
      vscode-extensions.vadimcn.vscode-lldb

      # formatters
      nixfmt-rfc-style
    ];

    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";

    stateVersion = "25.11";
  };

  xdg.configFile."nvim/" = {
    source = ./nvim;
    recursive = true;
  };
  
  programs = {
    fzf.enable = true;
    fzf.enableFishIntegration = true;
    zoxide.enable = true;
    zoxide.enableFishIntegration = true;
    zoxide.options = [ "--cmd cd" ];

    # languages
    gcc.enable = true;
    uv.enable = true;

    neovim.enable = true;

    starship.enable = true;
    starship.settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "bold 135";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      directory.style = "bold 69";
      python.disabled = true;
      ruby.disabled = true;
      username.show_always = true;
      username.style_user = "bold green";
      character.success_symbol = "[❯](172)";
      character.error_symbol = "[❯](red)";
      character.vimcmd_symbol = "[❮](subtext1)";
    };

    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user.name = "Aayush Borkar";
        user.email = "aayushb14@gmail.com";
        core.editor = "nvim";
        url = {
          "https://oauth2:${secrets.github_token}@github.com" = {
            insteadOf = "https://github.com";
          };
        };
      };
    };

    bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        fish_config theme choose fish\ default
        set -U fish_greeting
        fish_add_path --append /mnt/c/Users/aayus/scoop/apps/win32yank/current
      '';
      functions = {
        refresh = "source $HOME/.config/fish/config.fish";
        take = ''mkdir -p -- "$1" && cd -- "$1"'';
        ttake = "cd $(mktemp -d)";
        show_path = "echo $PATH | tr ' ' '\n'";
        posix-source = ''
          for i in (cat $argv)
            set arr (echo $i |tr = \n)
            set -gx $arr[1] $arr[2]
          end
        '';
      };
      shellAbbrs =
        {
          gc = "nix-collect-garbage --delete-old";
        }
        # navigation shortcuts
        // {
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "....." = "cd ../../../../";
        };
      shellAliases = {
        v = "nvim";
        x = "clear";
        py = "python3";
        ipy = "ipython";
        python = "python3";
        pbcopy = "/mnt/c/Windows/System32/clip.exe";
        pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
        explorer = "/mnt/c/Windows/explorer.exe";
        wezterm = "'/mnt/c/Program Files/WezTerm/wezterm.EXE'";

        l = "eza";
        ls = "eza --icons=always";
        ll = "eza --group --header --group-directories-first --long";
        lg = "eza --group --header --group-directories-first --long --git --git-ignore";
        le = "eza --group --header --group-directories-first --long --extended";
        lt = "eza --group --header --group-directories-first --tree --level LEVEL";
      };
      plugins = [
        {
          inherit (pkgs.fishPlugins.autopair) src;
          name = "autopair";
        }
        {
          inherit (pkgs.fishPlugins.sponge) src;
          name = "sponge";
        }
        {
          inherit (pkgs.fishPlugins.foreign-env) src;
          name = "foreign-env";
        }
      ];
    };
  };

}
