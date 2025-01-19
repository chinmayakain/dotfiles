# home.nix
# home-manager switch 

{ config, pkgs, ... }:

{
  home.username = "loki";
  # home.homeDirectory = /Users/loki;
  home.stateVersion = "23.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
   ".zshrc".source = builtins.toPath "/Users/loki/dotfiles/zsh/.zshrc";
   ".config/wezterm".source = builtins.toPath "/Users/loki/dotfiles/wezterm";
   ".config/skhd".source = builtins.toPath "/Users/loki/dotfiles/skhd";
   ".config/starship".source = builtins.toPath "/Users/loki/dotfiles/starship";
   ".config/nvim".source = builtins.toPath "/Users/loki/dotfiles/nvim";
   ".config/nix".source = builtins.toPath "/Users/loki/dotfiles/nix";
   ".config/aerospace".source = builtins.toPath "/Users/loki/dotfiles/aerospace";
   ".config/bat".source = builtins.toPath "/Users/loki/dotfiles/bat";
   ".tmux.conf".source = builtins.toPath "/Users/loki/dotfiles/tmux/.tmux.conf";
   ".config/tmux/tmux.reset.conf".source = builtins.toPath "/Users/loki/dotfiles/tmux/tmux.reset.conf";
    # ".config/sketchybar".source = ~/dotfiles/sketchybar;
    ".config/ghostty".source = ~/dotfiles/ghostty;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
