{ lib, pkgs, ... }:
let
  username = "aayush";
  secretFile = "${builtins.getEnv "HOME"}/homemanager/secrets.json";
  secrets = builtins.fromJSON (builtins.readFile secretFile);
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

      trashy

      git-filter-repo

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
      nixd

      # daps
      vscode-extensions.vadimcn.vscode-lldb

      # formatters
      nixfmt-rfc-style

      # C++ Libraries
      glew
      libGL
    ];

    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";

    stateVersion = "25.11";
  };

  xdg.configFile."nvim/lua" = {
    source = ./nvim/lua;
    recursive = true;
  };
  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;

  # clangd configuration
  home.file.".clang-format".source = ./.clang-format;

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
      format = lib.concatStrings [
        "$username"
        "$directory"
        "$git_branch"
        "$git_status"
        "$fill"
        "$c"
        "$elixir"
        "$elm"
        "$golang"
        "$haskell"
        "$java"
        "$julia"
        "$nodejs"
        "$nim"
        "$rust"
        "$scala"
        "$conda"
        "$python"
        "$time"
        "$line_break  "
        "[❯](fg:iris) "
      ];
      palette = "rose-pine";
      palettes.rose-pine = {
        overlay = "#26233a";
        love = "#eb6f92";
        gold = "#f6c177";
        rose = "#ebbcba";
        pine = "#31748f";
        foam = "#9ccfd8";
        iris = "#c4a7e7";
      };

      directory = {
        format = "[](fg:overlay)[ $path ]($style)[](fg:overlay) ";
        style = "bg:overlay fg:pine";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
        };
      };

      fill = {
        style = "fg:overlay";
        symbol = " ";
      };

      git_branch = {
        format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay) ";
        style = "bg:overlay fg:foam";
        symbol = "";
      };

      git_status = {
        disabled = false;
        style = "bg:overlay fg:love";
        format = ''[](fg:overlay)([$all_status$ahead_behind]($style))[](fg:overlay) '';
        up_to_date = "[ ✓ ](bg:overlay fg:iris)";
        untracked = "[?($count)](bg:overlay fg:gold)";
        stashed = "[\\$](bg:overlay fg:iris)";
        modified = "[!($count)](bg:overlay fg:gold)";
        renamed = "[»($count)](bg:overlay fg:iris)";
        deleted = "[✘($count)](style)";
        staged = "[++($count)](bg:overlay fg:gold)";
        ahead = ''[⇡(''${count})](bg:overlay fg:foam)'';
        diverged = ''
          ⇕[[](bg:overlay fg:iris)[⇡(''${ahead_count})](bg:overlay fg:foam)[⇣(''${behind_count})](bg:overlay fg:rose)[]](bg:overlay fg:iris)
        '';
        behind = ''[⇣(''${count})](bg:overlay fg:rose)'';
      };

      time = {
        disabled = false;
        format = " [](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
        style = "bg:overlay fg:rose";
        time_format = "%I:%M%P";
        use_12hr = true;
      };

      username = {
        disabled = false;
        format = "[](fg:overlay)[ $user ]($style)[](fg:overlay) ";
        show_always = true;
        style_root = "bg:overlay fg:iris";
        style_user = "bg:overlay fg:iris";
      };

      # Languages (all identical structure)
      c = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      elixir = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      elm = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      golang = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      haskell = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      java = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      julia = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      nodejs = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = "󰎙 ";
      };

      nim = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = "󰆥 ";
      };

      rust = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      scala = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      python = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$version ]($style)[](fg:overlay)";
        disabled = false;
        symbol = " ";
      };

      conda = {
        style = "bg:overlay fg:pine";
        format = " [](fg:overlay)[ $symbol$environment ]($style)[](fg:overlay)";
        disabled = false;
        symbol = "🅒 ";
      };
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
      shellAbbrs = {
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

        rm = "trash";
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
