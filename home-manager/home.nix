{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "finn";
    homeDirectory = "/home/finn";
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    # dev
    neovim
    zsh
    gh

    # utils
    kanata
    fastfetch
    fzf
    jq
    ripgrep
    tree
    btop
    feh
    playerctl
    xclip
    zoxide
    xdotool
    bat
    delta

    # font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/home-manager".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager";
    ".config/nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix";
    ".config/kanata/hrm-brick.kbd".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kanata/hrm-brick.kbd";
    ".config/systemd/user/kanata.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kanata/kanata.service";
    ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/i3";
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/alacritty";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/rofi";
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/git/gitconfig";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zsh/zshrc";
    ".p10k.zsh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zsh/p10k.zsh";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux/tmux.conf";
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/vim/vimrc";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
