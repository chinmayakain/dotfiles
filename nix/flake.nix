{
  description = "loki's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {

          nixpkgs.config.allowUnfree = true;

          # $ nix-env -qaP | grep wget
          #----=[ System Packages ]=----#
          environment.systemPackages = [
            pkgs.mkalias
            pkgs.vim
            pkgs.neovim
            pkgs.tmux
            pkgs.glow
            pkgs.awscli
            pkgs.git
            pkgs.zoxide
            pkgs.postgresql_16
            pkgs.fzf
            pkgs.bat
            pkgs.btop
            pkgs.ripgrep
            pkgs.zsh-autosuggestions
            pkgs.eza
            pkgs.lazygit
            pkgs.starship
            pkgs.zsh-syntax-highlighting
            pkgs.fd
            pkgs.lua
            pkgs.figlet
            pkgs.tree
            pkgs.tree-sitter
            pkgs.aerospace
            pkgs.neofetch
          ];

          #----=[ Homebrew ]=----#
          homebrew = {
            enable = true;
            taps = [
            ];
            brews = [
              "mas"
              "tmux-mem-cpu-load"
              "tpm"
              "node"
              "nvm"
              "fontconfig"
              "koekeishiya/formulae/skhd"
            ];
            casks = [
              "google-chrome"
              "arc"
              "iina"
              "raycast"
              "discord"
              "postman"
              "pgadmin4"
              "microsoft-teams"
              "wezterm"
              "visual-studio-code"
              "obsidian"
              "mos"
              "ghostty"
              "httpie"
              "font-jetbrains-mono"
            ];
            masApps = {
              Portal = 1436994560;
              Clock = 1181028777;
              Tailscale = 1475387142;
              Slack = 803453959;
              Outlook = 985367838;
            };
            # onActivation.cleanup = "uninstall";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          #----=[ Fonts ]=----#
          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
          ];

          #----=[ Aliases for application indexation ]=----#
          system.activationScripts.applications.text =
            let
              env = pkgs.buildEnv {
                name = "system-applications";
                paths = config.environment.systemPackages;
                pathsToLink = "/Applications";
              };
            in
            pkgs.lib.mkForce ''
              # Set up applications.
              echo "setting up /Applications..." >&2
              rm -rf /Applications/Nix\ Apps
              mkdir -p /Applications/Nix\ Apps
              find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
              while read -r src; do
                app_name=$(basename "$src")
                echo "copying $src" >&2
                ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
              done
            '';

          nix.settings.experimental-features = "nix-command flakes";

          #----=[ System setup ]=----#
          system.defaults = {
            dock.autohide = true;
            dock.mru-spaces = false;
            dock.tilesize = 52;
            dock.wvous-bl-corner = 11; # hot-corner bottom-left launchpad
            dock.wvous-br-corner = 4; # hot-corner bottom-right desktop
            dock.wvous-tr-corner = 2; # hot-corner top-right mission control
            dock.wvous-tl-corner = 1; # hot-corner top-left disabled
            dock.persistent-apps = [
              "/System/Applications/Mail.app"
              "/Applications/Microsoft Outlook.app"
              "/Applications/Arc.app"
              "/Applications/Google Chrome.app"
              "${pkgs.obsidian}/Applications/Obsidian.app"
              "/Applications/Visual Studio Code.app"
              "/Applications/WezTerm.app"
              "/Applications/Slack.app"
              "/Applications/Discord.app"
              "/Applications/Microsoft Teams.app"
              "/System/Applications/System Settings.app"
            ];
            finder.FXPreferredViewStyle = "clmv";
            finder.AppleShowAllExtensions = true;
            finder.ShowPathbar = true;
            finder.ShowStatusBar = true;
            loginwindow.LoginwindowText = "Welcome Loki!";
            loginwindow.GuestEnabled = false;
            screencapture.location = "~/Pictures/screenshots";
            screensaver.askForPasswordDelay = 300;
            NSGlobalDomain.AppleICUForce24HourTime = false;
            NSGlobalDomain.AppleInterfaceStyle = "Dark";
            NSGlobalDomain.KeyRepeat = 2;
            NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
            NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
            controlcenter.BatteryShowPercentage = true;
            trackpad.Clicking = true;
            trackpad.Dragging = true;
          };

          #----=[ System setup ]=----#
          system.keyboard.enableKeyMapping = true;
          system.keyboard.remapCapsLockToEscape = true;

          # programs.fish.enable = true;
          programs.zsh.enable = true;

          system.configurationRevision = self.rev or self.dirtyRev or null;

          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          #----=[ Service setup ]=----#
          services.nix-daemon.enable = true;
          security.pam.enableSudoTouchIdAuth = true;

          services.postgresql = {
            enable = true;
            package = pkgs.postgresql_16;
          };
          services.skhd.enable = true;

          users.users.loki = {
            name = "loki";
            home = "/Users/loki";
          };
          home-manager.backupFileExtension = "backup";
          nix.configureBuildUsers = true;
          nix.useDaemon = true;

          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.config.allowBroken = true;
        };

    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Chinmayas-MacBook-Air
      darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple sillicon only
              # enableRosetta = true;
              user = "loki";
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.loki = import ./home.nix;
          }
        ];
      };

      darwinPackages = self.darwinConfigurations."air".pkgs;
    };
}
