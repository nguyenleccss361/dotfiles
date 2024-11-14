{ config, pkgs, ... }:

{
  home.username = "nguyenlh6";
  home.homeDirectory = "/home/nguyenlh6";
  home.stateVersion = "24.11";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in './scripts' to '~/.config/i3/scripts'
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # dev
    neovim

    # utils
    i3
    i3status
    i3lock
  ];

  home.file = {
    ".config/i3".source = ~/dotfiles/.config/i3;
  };

  # xsession.windowManager.i3 = {
  #   enable = true;
  # };

  programs.home-manager.enable = true;
}
